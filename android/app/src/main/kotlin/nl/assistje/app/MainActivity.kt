package nl.assistje.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private var appIcon: AppIconChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        appIcon = AppIconChannel(this).also {
            it.register(flutterEngine.dartExecutor.binaryMessenger)
        }
    }

    override fun onStop() {
        super.onStop()
        // Op de achtergrond: nu kan het app-icoon wisselen (AppIconChannel).
        appIcon?.applyPending()
    }
}
