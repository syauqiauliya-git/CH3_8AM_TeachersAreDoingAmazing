//
//  Affirmations.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 03/06/26.
//

import Foundation
import SwiftData

@Model
class Affirmations {
    var id: UUID = UUID()
    var labels: [String]
    var isLiked: Bool
    var lastShown: Date
    
    init(labels: [String] = [], isLiked: Bool = false, lastShown: Date = .now) {
        self.labels = labels
        self.isLiked = isLiked
        self.lastShown = lastShown
    }
}
