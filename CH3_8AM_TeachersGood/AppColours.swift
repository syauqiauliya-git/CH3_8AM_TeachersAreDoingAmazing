//
//  AppColours.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

extension Color {
    static let appPrimary               = Color(hex: "#6B4DE6") // purple — buttons, accents
    static let appBackground            = Color(hex: "#FCFDFF") // page background
    
    static let appSpeechBubble          = Color(hex: "#EAE6FF") // lavender — bubble background
    static let appSpeechBubbleText      = Color(hex: "#232790")
    
    static let appGradeBorder           = Color(hex: "#CECECE")
    static let appGradeNotSelected      = Color(hex: "#F3F3F3")
    static let appGradeSelected         = Color(hex: "#FDD9A5") // amber — selected grade row
    static let appGradeNotSelectedText  = Color(hex: "#4A4DB2")
    static let appGradeSelectedText     = Color(hex: "#4723B5")
    
    static let appMascotOrange          = Color(hex: "#FF6B35") // mascot gradient start
    static let appMascotYellow          = Color(hex: "#FFC84A") // mascot gradient end
    
    static let appTextPrimary           = Color(hex: "#2D2D2D")
    static let appTextSecondary         = Color(hex: "#888888")


    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:  (a,r,g,b) = (255,(int>>8)*17,(int>>4 & 0xF)*17,(int & 0xF)*17)
        case 6:  (a,r,g,b) = (255,int>>16,int>>8 & 0xFF,int & 0xFF)
        case 8:  (a,r,g,b) = (int>>24,int>>16 & 0xFF,int>>8 & 0xFF,int & 0xFF)
        default: (a,r,g,b) = (255,255,255,255)
        }
        self.init(.sRGB,
                  red: Double(r)/255,
                  green: Double(g)/255,
                  blue: Double(b)/255,
                  opacity: Double(a)/255)
    }
}
