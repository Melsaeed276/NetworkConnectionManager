
//
//  CustomAlert.swift
//  AxBase
//
//  Created by Mohamed Elsaeed on 6.03.2024.
//

import Foundation
import SwiftUI






struct InternetAlert: View {
    
    @Environment(\.openURL) private var openURL
    
    let onCancel: () -> Void
    
    
    let image: String = "wifi.exclamationmark"
    

    init(onCancel: @escaping () -> Void){
 
        
        self.onCancel = onCancel
    }
    
    
    
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.4)
                           .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Add a VStack to arrange elements vertically
                VStack{
                    
                    Image(systemName: image)
                        .font(.extraLarge) // Adjust size as needed
                        .foregroundColor(.red) // Optional color
                        .padding(.bottom)
                    
                    Text("Internet Connection".localized())
                        .fontWeight(.bold) // Make the text bold
                        .colorMultiply(.black)
                        .font(.title2)
                        .padding(.bottom,10)
                    
                    Text("description".localized())
                        .colorMultiply(.black)
                        .padding(.horizontal,18)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                    
                    
                }.frame(maxWidth: .infinity,maxHeight: 200)
                    .padding(.top, 24)
                    .padding(.bottom,24)
                
                // Buttons
                HStack (spacing: 20){ // Use an HStack for horizontal button placement
                    // Add buttons
                    
                    Button("Open Settings".localized(),action:{
                        if let url = URL(string:"App-Prefs:root=WIFI") {
                            if UIApplication.shared.canOpenURL(url) {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                } else {
                                    UIApplication.shared.openURL(url)
                                }
                            }
                        }
                    })
                    .padding(.horizontal,24)
                    .padding(.vertical,12)
                    .frame( minWidth: 120)
                    .background(Color(uiColor: .blue))
                    .foregroundColor(.white) // Ensure text is visible
                    .cornerRadius(8)
                    
                    
                    
                    
                    
                    Button("Cancel".localized(),action:  onCancel)
                        .colorMultiply(.black)
                        .buttonStyle(.borderless)
                    
                    
                }
                .padding(.bottom, 24)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
            .padding(.horizontal,20)
            
        }
        .ignoresSafeArea()
        
    }
    
    
}



#Preview("Englsh"){
    InternetAlert(onCancel:{})
        .environment(\.locale, .init(identifier: "en"))
    
}

