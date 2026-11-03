import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Uploadsleutel voor Google Play (README → "Release (Android)"). Staat niet in
// git: android/key.properties + het .jks-bestand. Zonder dat bestand tekent de
// release-build met de debugsleutel, zodat CI en lokale builds blijven werken;
// zo'n build kan niet naar Play.
val keystoreProperties = Properties().apply {
    val file = rootProject.file("key.properties")
    if (file.exists()) file.inputStream().use { load(it) }
}
val hasUploadKey = keystoreProperties.getProperty("storeFile") != null

android {
    namespace = "nl.assistje.app"
    // Google Play: nieuwe apps en updates moeten sinds 31 augustus 2026
    // API 36 (Android 16) targeten. Vast, niet via flutter.*, zodat een
    // Flutter-update dit niet stilletjes verschuift.
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // flutter_local_notifications gebruikt java.time-API's.
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "nl.assistje.app"
        minSdk = 24
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // De app is alleen Nederlands: geen vertaalde resources uit
    // bibliotheken (AndroidX, Play Services) in de bundle.
    androidResources {
        localeFilters += listOf("nl")
        // Per-app-taal (Android 13+): res/xml/locales_config.xml.
        generateLocaleConfig = false
    }

    signingConfigs {
        if (hasUploadKey) {
            create("upload") {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = rootProject.file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (hasUploadKey) {
                signingConfigs.getByName("upload")
            } else {
                logger.warn(
                    "w: android/key.properties ontbreekt: de release-build wordt met de " +
                        "DEBUGSLEUTEL getekend en kan niet naar Google Play (README → Release (Android)).",
                )
                signingConfigs.getByName("debug")
            }
            // R8: code verkleinen/obfusceren en ongebruikte resources weg.
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
