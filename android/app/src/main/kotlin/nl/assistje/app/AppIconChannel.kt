package nl.assistje.app

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Het app-icoon wisselen tussen het standaardicoon en een clubwapen
 * (`nl.assistje.app/app_icon`, Dart: `lib/core/app_icon/app_icon_service.dart`).
 *
 * Android kent alleen de iconen van de launcher-ingangen in de manifest. Elk
 * icoon is daarom een `activity-alias` naar [MainActivity]: `DefaultIcon` en
 * per club een uitgeschakelde `ClubIcon<clubId>` (gegenereerde module
 * `android/club_icons`, `tool/app_icons.dart`). In de release-build is
 * `DefaultIcon` de launcher-ingang (src/release/AndroidManifest.xml) en staat
 * er precies één alias aan. In debug/profile blijft `MainActivity` zelf de
 * ingang (de Flutter-tool heeft die nodig) en komt een clubicoon ernaast.
 * [MainActivity] zelf wordt nooit uitgezet: dan vallen alle aliassen weg.
 *
 * Een wissel terwijl de app op de voorgrond staat kan hem op sommige
 * toestellen afsluiten; `set` onthoudt daarom alleen het nieuwe icoon en
 * [applyPending] (vanuit [MainActivity.onStop]) voert hem uit.
 *
 * - `status {name?}` → `{supported, current, available}`; `current` is het
 *   icoon dat staat (of klaarstaat), `null` = standaardicoon.
 * - `set {name}` → `null`; `name: null` = standaardicoon.
 */
class AppIconChannel(private val context: Context) : MethodChannel.MethodCallHandler {
    fun register(messenger: BinaryMessenger) {
        MethodChannel(messenger, NAME).setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "status" -> {
                val name = call.argument<String>("name")
                result.success(
                    mapOf(
                        "supported" to true,
                        "current" to currentName(),
                        "available" to (name != null && exists(aliasFor(name))),
                    ),
                )
            }
            "set" -> {
                val name = call.argument<String>("name")
                if (name != null && !exists(aliasFor(name))) {
                    result.error("unknown_icon", "Icoon $name zit niet in deze build.", null)
                    return
                }
                pending = if (name == enabledClubName()) null else Target(name)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    /** Zet het klaarstaande icoon; de app staat dan op de achtergrond. */
    fun applyPending() {
        val target = pending ?: return
        pending = null
        val clubs = launcherComponents().filter { it.startsWith(CLUB_PREFIX) }
        // Eerst de nieuwe aan, dan de rest uit: nooit zonder launcher-ingang.
        if (target.name == null) {
            // Manifeststand: aan in release, uit in debug/profile.
            setState(DEFAULT_ALIAS, PackageManager.COMPONENT_ENABLED_STATE_DEFAULT)
            clubs.forEach { setState(it, PackageManager.COMPONENT_ENABLED_STATE_DEFAULT) }
        } else {
            val alias = aliasFor(target.name)
            setState(alias, PackageManager.COMPONENT_ENABLED_STATE_ENABLED)
            clubs.filter { it != alias }
                .forEach { setState(it, PackageManager.COMPONENT_ENABLED_STATE_DEFAULT) }
            setState(DEFAULT_ALIAS, PackageManager.COMPONENT_ENABLED_STATE_DISABLED)
        }
    }

    private fun setState(alias: String, state: Int) =
        context.packageManager.setComponentEnabledSetting(
            component(alias),
            state,
            PackageManager.DONT_KILL_APP,
        )

    private fun currentName(): String? = pending?.let { return it.name } ?: enabledClubName()

    /** Het clubicoon dat nu aan staat, `null` = standaardicoon. */
    private fun enabledClubName(): String? =
        launcherComponents().firstNotNullOfOrNull(::nameFor)

    /** De launcher-ingangen die nu aan staan (één binder-aanroep). */
    private fun launcherComponents(): List<String> {
        val intent = Intent(Intent.ACTION_MAIN)
            .addCategory(Intent.CATEGORY_LAUNCHER)
            .setPackage(context.packageName)
        return context.packageManager.queryIntentActivities(intent, 0)
            .map { it.activityInfo.name }
    }

    private fun exists(alias: String): Boolean = try {
        context.packageManager.getActivityInfo(
            component(alias),
            PackageManager.MATCH_DISABLED_COMPONENTS,
        )
        true
    } catch (e: PackageManager.NameNotFoundException) {
        false
    }

    private fun component(alias: String) = ComponentName(context.packageName, alias)

    private companion object {
        const val NAME = "nl.assistje.app/app_icon"
        const val DEFAULT_ALIAS = "nl.assistje.app.DefaultIcon"
        const val CLUB_PREFIX = "nl.assistje.app.ClubIcon"
        const val DART_PREFIX = "ClubIcon-"

        /** Het icoon dat klaarstaat; `name == null` = standaardicoon. */
        data class Target(val name: String?)

        /** Overleeft een nieuwe FlutterEngine; weg als het proces stopt. */
        var pending: Target? = null

        /** `ClubIcon-12` → `nl.assistje.app.ClubIcon12`. */
        fun aliasFor(name: String) = CLUB_PREFIX + name.removePrefix(DART_PREFIX)

        fun nameFor(alias: String): String? =
            if (alias.startsWith(CLUB_PREFIX)) DART_PREFIX + alias.removePrefix(CLUB_PREFIX) else null
    }
}
