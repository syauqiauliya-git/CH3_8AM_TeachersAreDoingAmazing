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
    var labels: [String]
    var isBookmarked: Bool
    var lastShown: Date
    
    init(labels: [String] = [], isBookmarked: Bool = false, lastShown: Date = .now) {
        self.labels = labels
        self.isBookmarked = isBookmarked
        self.lastShown = lastShown
    }
}
