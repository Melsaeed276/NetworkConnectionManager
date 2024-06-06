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
    func showInternetAlert(onCancel: @escaping () -> Void,networkController: NetworkStatusController = .shared) -> some View {
        self.modifier(InternetAlertModifier(onCancel: onCancel, networkController: networkController))
    }
}

public extension UIViewController {
    
    private struct HostingControllerHolder {
           static var hostingController: UIHostingController<InternetAlert>?
       }
       
       func showInternetAlert(onCancel: @escaping () -> Void) {
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
       
       func dismissInternetAlert() {
           if let hostingController = HostingControllerHolder.hostingController {
               hostingController.dismiss(animated: true, completion: nil)
               HostingControllerHolder.hostingController = nil
           }
       }
}


