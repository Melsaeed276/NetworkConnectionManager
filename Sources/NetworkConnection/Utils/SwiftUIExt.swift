//
//  SwiftUIExtension.swift
//
//
//  Created by Mohamed Elsaeed on 5.06.2024.
//

import SwiftUI



struct InternetAlertModifier: ViewModifier {
    @State private var isPresented = false
    
    let onCancel: () -> Void
    
    let networkController: NetworkStatusController
    let animationDuration: Double = 0.3 // Customize the animation duration here

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                InternetAlert(onCancel: onCancel)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: animationDuration), value: isPresented)
            }
        }
        .onAppear {
            networkController.setStatusChangeHandler { isConnected, _ in
                withAnimation(.easeInOut(duration: animationDuration)) {
                    isPresented = !isConnected
                }
            }
        }
    }
}
