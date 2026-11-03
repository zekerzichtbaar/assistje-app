package nl.assistje.app

import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.RectF
import androidx.core.content.pm.ShortcutInfoCompat
import androidx.core.content.pm.ShortcutManagerCompat
import androidx.core.graphics.drawable.IconCompat
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.math.sqrt

/**
 * Het clubwapen op het beginscherm (`nl.assistje.app/app_icon`, Dart:
 * `lib/core/app_icon/app_icon_service.dart`).
 *
 * iOS wisselt het app-icoon zelf (alternatieve iconen in de build,
 * AppDelegate.swift). Op Android kan dat alleen met een `activity-alias` per
 * icoon in de manifest: voor ~4100 clubs onwerkbaar, en een wissel herstart de
 * app en haalt bestaande snelkoppelingen weg. Daarom hier een vastgezette
 * snelkoppeling (pinned shortcut) met het clublogo, gemaakt uit het logo dat
 * de app downloadt: er zit niets in de build, dus het werkt voor elke club. Het
 * gewone icoon blijft in de app-lade staan.
 *
 * - `status {name}` → `{supported, current, available, mode: "shortcut"}`;
 *   `current` is [name] als die snelkoppeling al op het beginscherm staat.
 * - `pinShortcut {id, label, png}` → `"requested"` (de launcher vraagt de
 *   gebruiker om bevestiging) of `"updated"` (stond er al; nieuw logo).
 * - `set` (iOS) bestaat hier niet.
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
                        "supported" to ShortcutManagerCompat.isRequestPinShortcutSupported(context),
                        "current" to name?.takeIf { isPinned(it) },
                        "available" to true,
                        "mode" to "shortcut",
                    ),
                )
            }
            "pinShortcut" -> pinShortcut(call, result)
            else -> result.notImplemented()
        }
    }

    private fun pinShortcut(call: MethodCall, result: MethodChannel.Result) {
        val id = call.argument<String>("id")
        val label = call.argument<String>("label")
        val png = call.argument<ByteArray>("png")
        if (id.isNullOrEmpty() || label.isNullOrEmpty() || png == null) {
            result.error("bad_args", "id, label en png zijn verplicht.", null)
            return
        }
        // PNG, JPEG, WebP en GIF; een SVG-logo laat de Dart-kant al weg.
        val logo = BitmapFactory.decodeByteArray(png, 0, png.size)
        if (logo == null) {
            result.error("bad_image", "Het clublogo is geen leesbare afbeelding.", null)
            return
        }

        val launch = Intent(context, MainActivity::class.java)
            .setAction(Intent.ACTION_MAIN)
            .addCategory(Intent.CATEGORY_LAUNCHER)
        val shortcut = ShortcutInfoCompat.Builder(context, id)
            .setShortLabel(label)
            .setLongLabel(label)
            .setIcon(IconCompat.createWithAdaptiveBitmap(adaptiveIcon(logo)))
            .setIntent(launch)
            .build()

        try {
            if (isPinned(id)) {
                // Staat er al: alleen het icoon (en de naam) bijwerken.
                ShortcutManagerCompat.updateShortcuts(context, listOf(shortcut))
                result.success("updated")
            } else if (ShortcutManagerCompat.requestPinShortcut(context, shortcut, null)) {
                result.success("requested")
            } else {
                result.error("unsupported", "Deze launcher kan geen snelkoppeling vastzetten.", null)
            }
        } catch (e: IllegalStateException) {
            // Bijv. een vastzetverzoek terwijl de app op de achtergrond staat.
            result.error("failed", e.message, null)
        }
    }

    private fun isPinned(id: String): Boolean =
        ShortcutManagerCompat.getShortcuts(context, ShortcutManagerCompat.FLAG_MATCH_PINNED)
            .any { it.id == id }

    /**
     * Logo gecentreerd op wit, op een adaptief-icooncanvas (108 dp, hier
     * 4 px per dp). De launcher maskeert alles buiten de veilige zone (cirkel
     * van 66 dp), dus het logo past met zijn diagonaal in die cirkel.
     */
    private fun adaptiveIcon(logo: Bitmap): Bitmap {
        val canvasSize = ICON_PX
        val safe = canvasSize * SAFE_ZONE
        val scale = safe / sqrt((logo.width * logo.width + logo.height * logo.height).toFloat())
        val w = logo.width * scale
        val h = logo.height * scale
        val left = (canvasSize - w) / 2f
        val top = (canvasSize - h) / 2f

        val icon = Bitmap.createBitmap(canvasSize, canvasSize, Bitmap.Config.ARGB_8888)
        Canvas(icon).apply {
            drawColor(Color.WHITE)
            drawBitmap(
                logo,
                null,
                RectF(left, top, left + w, top + h),
                Paint(Paint.ANTI_ALIAS_FLAG or Paint.FILTER_BITMAP_FLAG),
            )
        }
        return icon
    }

    private companion object {
        const val NAME = "nl.assistje.app/app_icon"

        /** 108 dp × 4 (xxxhdpi). */
        const val ICON_PX = 432

        /** Veilige zone van een adaptief icoon: 66 van 108 dp. */
        const val SAFE_ZONE = 66f / 108f
    }
}
