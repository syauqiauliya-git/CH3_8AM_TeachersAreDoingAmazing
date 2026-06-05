
//  Affirmations.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 03/06/26.
//

import Foundation
import SwiftData

@Model
class Affirmation {
    var id: UUID = UUID()
    
    @Relationship(deleteRule: .cascade)
    var tokens: [AffirmationToken]
    
    var labels: [String]
    var lastShown: Date?
    
//    static let sampleAffirmations: [Affirmation] = [
//        Affirmation(text: "You go girl!"),
//        Affirmation(text: "Woah!"),
//        Affirmation(text: "You're doing so good")
//    ]
    
    init(tokens: [AffirmationToken] = [], labels: [String] = [], lastShown: Date? =  nil) {
        self.tokens = tokens
        self.labels = labels
        self.lastShown = lastShown
    }
}
