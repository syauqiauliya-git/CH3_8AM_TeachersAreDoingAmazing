//
//  Stories.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 03/06/26.
//

import Foundation
import SwiftData

class Story {
//    var id: UUID = UUID()
    var labels: [String]
    var image: String
    var isBookmarked: Bool
    var storyDate: Date
    
    init(labels: [String] = [], image: String = "", isBookmarked: Bool = false, storyDate: Date = Date()) {
        self.labels = labels
        self.image = image
        self.isBookmarked = isBookmarked
        self.storyDate = storyDate
    }
}
