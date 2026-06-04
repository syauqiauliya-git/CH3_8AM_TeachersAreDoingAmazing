
//  Affirmations.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 03/06/26.
//

import Foundation
import SwiftData

@Model
class Affirmation {
    //    var id: UUID = UUID()
    @Relationship(deleteRule: .cascade)
    var tokens: [AffirmationToken]
    
    var text: String
    var labels: [String]
    var isLiked: Bool
    var lastShown: Date?
    
    static let sampleAffirmations: [Affirmation] = [
        Affirmation(text: "You go girl!"),
        Affirmation(text: "Woah!"),
        Affirmation(text: "You're doing so good")
 

    ]
    
    init(tokens: [AffirmationToken] = [], text: String = "", labels: [String] = [], isLiked: Bool = false, lastShown: Date? =  nil) {
        self.tokens = tokens
        self.text = text
        self.labels = labels
        self.isLiked = isLiked
        self.lastShown = lastShown
    }
}
