//
//  RecordingState.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 29/05/26.
//

import Foundation

enum RecordingState {
    case readyOnboarding
    case ready
    
    case recording
    
    case finishedOnboarding
    case finished
    
    case next

    var bubbleText: String {
        switch self {
        case .readyOnboarding:
            return "Could you tell me why you became a teacher?"
        case .ready:
            return "Hey, have something\nto share?"
        case .recording:
            return "Go on! I’m all ears."
        case .finishedOnboarding:
            return "I'm always here to listen. Thank you for sharing!"
        case .finished:
            return "Do you want to try that again?"
        case .next:
            return "Thank you for telling\nme about your day!"
        }
    }
    
    var thingyMode: String {
        switch self{
        case .recording:
            return ThingyState.listen.mode
        default:
            return ThingyState.idle.mode
        }
    }

}
