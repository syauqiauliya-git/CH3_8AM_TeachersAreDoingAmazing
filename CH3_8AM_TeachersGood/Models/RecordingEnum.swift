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

    // Computed property untuk teks bubble
    var bubbleText: String {
        switch self {
        case .ready:
            return "What's up, teach?"
        case .recording:
            return "Go on! I'm listening."
        case .finished:
            return "Thank you for telling me about your day!"
        }
    }
}
