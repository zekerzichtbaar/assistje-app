import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Voorgrondmeldingen (flutter_local_notifications) en tikken erop
    // (firebase_messaging) lopen via deze delegate.
    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "AssistjeAppIcon") {
      AppIconChannel.register(with: registrar.messenger())
    }
  }
}

/// Het app-icoon wisselen tussen het standaardicoon en een clubwapen dat in de
/// build zit (`tool/app_icons.dart`). iOS toont na een wissel zelf een melding.
enum AppIconChannel {
  static func register(with messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: "nl.assistje.app/app_icon", binaryMessenger: messenger)
    channel.setMethodCallHandler { call, result in
      let app = UIApplication.shared
      switch call.method {
      case "status":
        // Of dit toestel kan wisselen, welk icoon nu staat, en of het
        // gevraagde icoon in deze build zit.
        let name = (call.arguments as? [String: Any])?["name"] as? String
        result([
          "supported": app.supportsAlternateIcons,
          "current": app.alternateIconName as Any,
          "available": name.map(isBundled) ?? false,
          // Android: "shortcut" (vastgezette snelkoppeling, AppIconChannel.kt).
          "mode": "alternate",
        ])
      case "set":
        let name = (call.arguments as? [String: Any])?["name"] as? String
        if let name, !isBundled(name) {
          result(FlutterError(code: "unknown_icon", message: "Icoon \(name) zit niet in deze build.", details: nil))
          return
        }
        whenActive {
          app.setAlternateIconName(name) { error in
            DispatchQueue.main.async {
              if let error {
                result(FlutterError(code: "failed", message: error.localizedDescription, details: nil))
              } else {
                result(nil)
              }
            }
          }
        }
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  /// iOS weigert `setAlternateIconName` als de app niet actief is (tijdens het
  /// opstarten of op de achtergrond): dan wachten tot hij dat wel is.
  private static func whenActive(_ action: @escaping () -> Void) {
    if UIApplication.shared.applicationState == .active {
      action()
      return
    }
    var token: NSObjectProtocol?
    token = NotificationCenter.default.addObserver(
      forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main
    ) { _ in
      if let token { NotificationCenter.default.removeObserver(token) }
      action()
    }
  }

  /// Xcode zet elke `ClubIcon-*.appiconset` als alternatief icoon in Info.plist.
  private static func isBundled(_ name: String) -> Bool {
    ["CFBundleIcons", "CFBundleIcons~ipad"].contains { key in
      let icons = Bundle.main.object(forInfoDictionaryKey: key) as? [String: Any]
      let alternates = icons?["CFBundleAlternateIcons"] as? [String: Any]
      return alternates?[name] != nil
    }
  }
}
