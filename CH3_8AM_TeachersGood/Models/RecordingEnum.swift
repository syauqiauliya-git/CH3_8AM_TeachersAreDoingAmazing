//
//  RecordingState.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 29/05/26.
//

import Foundation

enum RecordingState {
    case ready
    case recording
    case finished
    case next

    var bubbleText: String {
        switch self {
        case .ready:
            return "Hey, have something\nto share?"
        case .recording:
            return "Go on! I’m all ears."
        case .finished:
            return "Feeling any better? Or\ndo you want to try that\nagain?"
        case .next:
            return "Thank you for telling\nme about your day!"
        }
    }
    
    var thingyMode: String {
        switch self{
        case .ready:
            return ThingyState.idle.mode
        case .recording:
            return ThingyState.listen.mode
        default:
            return ThingyState.idle.mode
        }
    }

}
