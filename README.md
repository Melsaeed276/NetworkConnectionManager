# NetworkManager

NetworkManager is an iOS library for monitoring network connectivity status and quality. It allows you to easily detect when the device is connected or disconnected from the internet, as well as assess the quality of the connection.

## Features

- Real-time network status monitoring
- Internet connectivity and quality checks
- Delegate-based notifications for seamless integration
- SwiftUI support for displaying network alerts
- Example usage included for quick implementation

## Installation

You can integrate NetworkManager into your Xcode project using Swift Package Manager. Follow the steps below:

1. In Xcode, go to `File` -> `Add Packages...`.
2. Enter the URL of the repository: `https://github.com/yourusername/NetworkManager`.
3. Follow the prompts to complete the installation.

## Usage

### Using for SwiftUI 
#### Step 1: just add it: In your exist code after import the NetworkConnection Library you can just call it in that way `.showInternetAlert({ //your code })'


Example usage:
```swift

import SwiftUI
import NetworkConnection

struct ContentView: View {
    
    var body: some View {
        VStack {
         // your code
    }
    .showInternetAlert(
         onCancel:{
             print("ON Cancel called")
             exit(0)
         }) // End of the showInternetAlert
     }
```
    
    

### Using for UIKit 

#### Step 1: Implementing `InternetConnectionDelegate'
#### Step 2: creating Create a class or view controller that implements the `InternetConnectionDelegate` protocol to receive updates about network status and quality.


```swift
import UIKit
import NetworkManager

class SomeViewController: UIViewController, InternetConnectionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkStatusController.shared.addDelegate(self)
    }

    deinit {
        NetworkStatusController.shared.removeDelegate(self)
    }

    func internetConnectionStatusDidChange(connected: Bool) {
        if connected {
            dismissInternetAlert()
        } else {
            showInternetAlert {
                print("Internet alert canceled")
                //you code 
            }
        }
    }

    func internetConnectionQualityDidChange(quality: NetworkStatusController.ConnectionQuality) {
        // Handle quality changes if needed
    }
}
```
## License 

[MIT License](LICENSE)
