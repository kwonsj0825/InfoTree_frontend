plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.dongguk.infotree.info_tree"
    compileSdk = 34
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.dongguk.infotree.info_tree"

        minSdk = 21           // 또는 flutter.minSdkVersion.toInt() (가능 시)
        targetSdk = 34        // 또는 flutter.targetSdkVersion.toInt()

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // ✅ 임시로 debug 키 사용
        }
    }
}

flutter {
    source = "../.."
}
