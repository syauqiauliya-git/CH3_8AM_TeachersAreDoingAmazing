//
//  Teacher.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 05/06/26.
//

import Foundation
import SwiftData

@Model
class Teacher {
    var name: String
    var grade: String
    var affirmationInterval: String
    var savedStories: [Story]
    var likedAffirmations: [Affirmation]

    init(name: String = "", grade: String = "", affirmationInterval: String = "", savedStories: [Story] = [], likedAffirmations: [Affirmation] = []) {
        self.name = name
        self.grade = grade
        self.affirmationInterval = affirmationInterval
        self.savedStories = savedStories
        self.likedAffirmations = likedAffirmations
    }
}
