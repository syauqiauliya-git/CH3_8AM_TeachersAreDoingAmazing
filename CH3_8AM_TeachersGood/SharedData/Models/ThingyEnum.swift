//
//  ThingyEnum.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 05/06/26.
//

import Foundation

enum ThingyState {
    case idle
    case listen
    case lookright
    case smile
    
    var mode: String {
        switch self{
        case .idle:
            return "ThingyIdle"
        case .listen:
            return "ThingyListen"
        case .lookright:
            return "ThingyLookRight"
        case .smile:
            return "ThingySmile"
        }
    }
    
    var accessibilityText: String {
        switch self {
        case .idle:
            return "Thingy is idling"
        case .listen:
            return "Thingy is listening"
        case .lookright:
            return "Thingy is looking to the right"
        case .smile:
            return "Thingy is smiling"
        }
    }
}
