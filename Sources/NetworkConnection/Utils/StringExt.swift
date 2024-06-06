//
//  File.swift
//  
//
//  Created by Mohamed Elsaeed on 30.05.2024.
//

import Foundation


extension String{
    
    func localized() -> String {
        let localized = NSLocalizedString(self, comment: "")
        if(localized == self){
            return NSLocalizedString(self,bundle: .module, comment: "")
        }
        return localized
    }
}
