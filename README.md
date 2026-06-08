## Prerequisites

Before running or building the application, ensure your environment meets the following requirement:

* **Android Studio Version**:
`Android Studio Otter 3 Feature Drop | 2025.2.3`

* **Flutter SDK**: `Channel stable, 3.38.9`

## Getting Started

### Google Maps API Configuration

To use the mapping features, you must generate your own Google Maps API key via the Google Cloud
Console and configure both platform-specific files as detailed below.

#### 1. Android Setup

Open your Android manifest file located at:
`android/app/src/main/AndroidManifest.xml`

Add your API key inside the `<application>` tag using the following `<meta-data>` element:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application>
        <meta-data 
            android:name="com.google.android.geo.API_KEY"
            android:value="YOUR_API_KEY_HERE" />
   </application>
</manifest>
```

#### 2. iOS Setup

Open your iOS application delegate file located at `ios/Runner/AppDelegate.swift`

Import `GoogleMaps` and specify your API key inside the
`application(_:didFinishLaunchingWithOptions:)` method before
`GeneratedPluginRegistrant.register(with:):`

```swift
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
```