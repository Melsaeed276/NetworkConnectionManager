//
//  File.swift
//
//
//  Created by Mohamed Elsaeed on 27.05.2024.
//

import SwiftUI
import UIKit
import Combine
import Network

public extension View {
    /// Presents an internet alert using a SwiftUI view modifier.
    ///
    /// This function provides a way to present an `InternetAlert` SwiftUI view as a modifier.
    /// It displays the alert when network connectivity changes are detected and allows the user to cancel it.
    ///
    /// - Parameters:
    ///   - onCancel: A closure that is executed when the cancel button is pressed.
    ///   - networkController: An instance of `NetworkStatusController` to monitor network changes. Defaults to `.shared`.
    /// - Returns: A modified view that includes the `InternetAlert`.
    ///
    /// Example usage:
    /// ```swift
    /// struct ContentView: View {
    ///
    /// var body: some View {
    /// VStack {
    ///     //your code
    /// }
    /// .showInternetAlert(
    ///     onCancel:{
    ///         print("ON Cancel called")
    ///           exit(0)
    ///     }) // End of the showInternetAlert
    ///
    /// }
    /// ```
    ///
    func showInternetAlert(onCancel: @escaping () -> Void,networkController: NetworkStatusController = .shared) -> some View {
        self.modifier(InternetAlertModifier(onCancel: onCancel, networkController: networkController))
    }
}

/**
 Extension for UIViewController that provides additional functionality related to network connections.
 */
public extension UIViewController {
    
    private struct HostingControllerHolder {
        static var hostingController: UIHostingController<InternetAlert>?
    }
    
    /**
     Shows an internet alert with a cancel action.
     
     - Parameter onCancel: A closure to be executed when the cancel action is triggered.
     
     ## Example of use:
     ```swift
     
     class ViewController: UIViewController,InternetConnectionDelegate {
     
     
     func yourFunction (){
     
     showInternetAlert(onCancel: {
     print("Cancel action triggered")
     })
     }
     
     }
     
     ```
     ## 2nd Example of use with in the InternetConnectionDelegate:
     ```swift
     
     class ViewController: UIViewController,InternetConnectionDelegate {
     
     
        func internetConnectionStatusDidChange(connected: Bool) {
            
            if !connected {
                self.showInternetAlert {
                // Handle cancel action here
                print("Internet alert canceled")
                self.dismissInternetAlert()
            }
            }else {
                
                self.dismissInternetAlert()
            }
        }
     
     }
     ```
     */
    func showInternetAlert(onCancel: @escaping () -> Void) {
        // Function implementation goes here
        
        // Check if an alert is already being presented
        if HostingControllerHolder.hostingController != nil {
            return
        }
        
        // Initialize the SwiftUI view
        let swiftUIView = InternetAlert(onCancel: {
            onCancel()
            self.dismissInternetAlert()
        })
        
        // Embed the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: swiftUIView)
        HostingControllerHolder.hostingController = hostingController
        
        // Present the UIHostingController modally
        hostingController.modalPresentationStyle = .overFullScreen
        hostingController.modalTransitionStyle = .crossDissolve
        hostingController.view.backgroundColor = .clear
        present(hostingController, animated: true, completion: nil)
    }
    
    
    
    /// Dismiss Internet Alert after show it
    ///   ##Example of use with in the InternetConnectionDelegate:
    /// ```swift
    ///
    ///class ViewController: UIViewController,InternetConnectionDelegate {
    ///
    ///     func internetConnectionStatusDidChange(connected: Bool) {
    ///           if !connected {
    ///              self.showInternetAlert {
    ///               // Handle cancel action here
    ///                print("Internet alert canceled")
    ///                self.dismissInternetAlert()
    ///               }
    ///            }else {
    ///                 self.dismissInternetAlert()
    ///             }
    ///     }//end of the function
    ///
    ///} //End of class
    ///```
    func dismissInternetAlert() {
        if let hostingController = HostingControllerHolder.hostingController {
            hostingController.dismiss(animated: true, completion: nil)
            HostingControllerHolder.hostingController = nil
        }
    }
}


