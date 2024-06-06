
//
//  CustomAlert.swift
//  AxBase
//
//  Created by Mohamed Elsaeed on 6.03.2024.
//

import Foundation
import SwiftUI







public struct InternetAlert: View {
    @Environment(\.presentationMode) var presentationMode
    
    let image : String
   
    
    
    let primaryButtonTitle: String?
    let primaryButtonAction: () -> Void
    
    let secondaryButtonTitle: String?
    let secondaryButtonAction: () -> Void
    
//     init(image: String,
//         primaryButtonTitle: String?,
//         primaryButtonAction: @escaping () -> Void,
//         
//         secondaryButtonTitle: String?,
//         secondaryButtonAction: @escaping () -> Void
//    ) {
//        self.image = image
//        
//        self.secondaryButtonTitle = secondaryButtonTitle
//        self.primaryButtonTitle = primaryButtonTitle
//        self.primaryButtonAction = primaryButtonAction
//        self.secondaryButtonAction = secondaryButtonAction
//    }
//    
//    init(
//        image: String,
//        primaryButtonTitle: String?,
//        primaryButtonAction: @escaping () -> Void) {
//        self.image = image
//
//     
//        self.primaryButtonTitle = primaryButtonTitle
//        self.primaryButtonAction = primaryButtonAction
//            
//            self.secondaryButtonTitle = nil
//            self.secondaryButtonAction = {}
//            
//          
//    }
//
//    init(image: String) {
//        self.image = image
//        self.secondaryButtonTitle = "ok"
//        self.primaryButtonTitle = nil
//        self.primaryButtonAction = {}
//        self.secondaryButtonAction = {}
//    }
    
    var body: some View {
        
        ZStack {
            Color(.white)
                .opacity(0.1)
            VStack(spacing: 0) {
                // Add a VStack to arrange elements vertically
                VStack{
                    
                    Image(systemName: image)
                        .font(.extraLarge) // Adjust size as needed
                        .foregroundColor(.red) // Optional color
                        .padding(.bottom)
                    
                    Text("title")
                        .fontWeight(.bold) // Make the text bold
                        .colorMultiply(.black)
                        .font(.title2)
                        .padding(.bottom,10)
                      
                    Text("description")
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
                    if(primaryButtonTitle != nil){
                        Button(primaryButtonTitle!,action: primaryButtonAction)
                        .padding(.horizontal,24)
                        .padding(.vertical,12)
                        .frame( maxWidth: secondaryButtonTitle == nil ? 300: nil)
                        .background(Color(uiColor: .blue))
                        .foregroundColor(.white) // Ensure text is visible
                        .cornerRadius(8)
                        
                    }
                    
                    
                    if(secondaryButtonTitle != nil){
                        Button(secondaryButtonTitle!,action: secondaryButtonAction )
                        .colorMultiply(.black)
                        .buttonStyle(.borderless)
                    }
    
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
    InternetAlert(
        image: "wifi.exclamationmark",
      
        primaryButtonTitle: "go_to_settings",
        primaryButtonAction: {

            
        },
        
        secondaryButtonTitle: "close_app",
        secondaryButtonAction: {
           
        }
        
    )
    .environment(\.locale, .init(identifier: "EN"))

}

#Preview("Turkish"){
    InternetAlert(
        image: "wifi.exclamationmark",
        primaryButtonTitle: "go_to_settings",
        primaryButtonAction: {

            
        },
        
        secondaryButtonTitle: "close_app",
        secondaryButtonAction: {
           
        }
        
    )
    .environment(\.locale, Locale(identifier: "TR"))
}
