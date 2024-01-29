### OrdKit is lightweight Swift JSON Api client for Ordinals server

It covers all of the JSON API endpoints and provides a simple way to interact with your Ordinals server. If there is something missing, please open an issue or a pull request.

## Installation
Add the package via SPM

## Usage
OrdKit is a simple static struct that you can use to interact with your Ordinals server.

```swift
import OrdKit

// Initialize OrdKit with your JSON Enabled Ordinals API
// This only needs to be done once as it simply sets the static baseURL
OrdKit.set(baseURL: "<ord server url>")

// Then you can use the static methods to interact with your Ordinals server
do {
    let result = try await OrdKit.API.getInscriptions()
} catch {
    print(error.localizedDescription)
}
```

Take a look at the Tests for more examples. You can run them by adding your Ordinals server url to the `OrdKitTests.swift` in the setup method.
