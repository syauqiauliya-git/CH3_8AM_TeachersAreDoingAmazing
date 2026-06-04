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
            return "What's up, teach?"

        case .recording:
            return "Go on! I'm listening."
        case .finished:
            return "Thank you for telling\nme about your day!"
        case .next:
            return "It's okay if you don't have a \ngrand reason today. Taking a \nbreath is enough. These are \nthe story that might be relevant"
        }
    }
}
