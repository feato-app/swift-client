# Feato Swift SDK

Simple feature flag management for iOS applications.

The Feato Swift SDK allows iOS apps to read feature flags safely and predictably, without always-on connections or background polling.
It is designed to be cache-first, battery-friendly, and fully under application control.

---

## Features

- 🚀 Simple feature flag access
- 📦 Cache-first, offline-safe
- 🔋 No background connections or polling
- 🧠 Explicit refresh model
- 🛡️ Safe defaults and graceful failure
- 🧩 Native Swift & SwiftUI friendly
- 📱 Designed for iOS applications

---

## Requirements

- iOS **15.0+**
- Swift **5.9+**
- Xcode **15+**

---

## Installation

Feato is distributed via **Swift Package Manager**.

### Using Xcode

1. Open your project in Xcode
2. Go to **File → Add Packages**
3. Enter the repository URL:

```
https://github.com/feato-app/swift-client
```

4. Select a version and add the package
5. Import Feato in your code:

```swift
import Feato
```

---

## Basic usage

### 1. Configure Feato

Configure Feato once during application startup.

```swift
@main
struct MyApp: App {
    init() {
        Feato.configure(
            projectKey: "YOUR_PROJECT_KEY",
            environment: .prod
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

Configuration:
- loads flags or cached flags if available
- never blocks app startup

---

### 2. Read feature flags

Feature flags are accessed synchronously.

```swift
if Feato.flag("new_dashboard") {
    NewDashboardView()
}
```

Behavior:
- flags are always available immediately
- missing flags resolve to `false`
- no async or callbacks required

---

### 3. Refresh flags

Refreshing flags is **explicit** and fully controlled by the app.

```swift
Task {
    await Feato.refresh()
}
```

Typical refresh moments:
- app launch
- app foreground
- pull-to-refresh
- settings screen

If refresh fails:
- cached flags remain in use
- no errors are thrown into UI code

---

## Feature flag model

Feato uses a simple boolean flag model:

```swift
flag(key: String) -> Bool
```

This ensures:
- predictable behavior
- minimal runtime overhead
- easy reasoning in production code

---

## Offline & failure behavior

Feato is designed to fail safely:

- network errors do not crash the app
- last known flag state is preserved
- flags never block critical application flows

This guarantees stability in production environments.

---

## Threading & concurrency

- All public APIs are `@MainActor`
- Designed for SwiftUI and UIKit
- No manual synchronization required

Feato does not spawn background threads or maintain long-lived connections.

---

## Environments

Supported environments:

```swift
.prod
.stage
.dev
.qa
.preview
```

Environment must match the project configuration in the Feato Portal.

---

## When to use Feato on iOS

Feato is ideal when you need to:

- control feature exposure after App Store release
- safely disable problematic features
- run controlled rollouts
- keep mobile apps battery-friendly

Feato intentionally avoids real-time streaming on mobile.

---

## Versioning

- Semantic Versioning (SemVer)
- `1.0.0` indicates a stable public API
- Breaking changes result in a new major version

---

## License

MIT © Feato

---

## Support

- Documentation: https://feato.io/docs
- Console: https://app.feato.io

---

## Summary

Feato Swift SDK is intentionally simple.
It prioritizes safety, predictability, and developer control over real-time complexity.
