//
//  FontExt.swift
//  NetworkManager
//
//  Created by Mohamed Elsaeed on 22.05.2024.
//


import Foundation
import SwiftUI


/// Extension for custom fonts.
public extension Font {
    
    /// Extra large font size.
    static let extraLarge = Font.system(size: 70)
    
    /// Super large font size with rounded design.
    static let superLarge = Font.system(size: 90, design: .rounded)
    
    /// Title font with size 18.
    static let onboardTitle = Font.custom("Helvetica", size: 18)
    
    /// Body font with size 14.
    static let onboardBody = Font.custom("Helvetica", size: 14)
    
    /// Body font with size 16.
    static let onboardSubTitle = Font.custom("Helvetica", size: 16)
    
    /// Caption font with size 12.
    static let onboardCaption = Font.custom("Helvetica", size: 12)
    
    /// Headline font with size 24.
    static let onboardHeadline = Font.custom("Helvetica", size: 24)
    
    /// Headline font with size 20.
    static let onboardSubHeadline = Font.custom("Helvetica", size: 20)
}

