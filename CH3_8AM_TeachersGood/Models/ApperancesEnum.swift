//
//  ApperancesEnum.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 07/06/26.
//

import SwiftUI

enum AppearanceMode: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case system = "System Default"
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
}
