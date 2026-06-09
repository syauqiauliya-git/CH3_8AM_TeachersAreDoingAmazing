//
//  Stories.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 03/06/26.
//

import Foundation
import SwiftData

@Model
class Story {
    var id: UUID = UUID()
    var labels: [String]
    var title: String
    var mdFileName: String
    var image: String
    var summary: String
    var isBookmarked: Bool
    var storyDate: Date
    
    init(labels: [String] = [], title: String = "", mdFileName: String = "", image: String = "", summary: String = "", isBookmarked: Bool = false, storyDate: Date = Date()) {
        self.labels = labels
        self.title = title
        self.mdFileName = mdFileName
        self.image = image
        self.summary = summary
        self.isBookmarked = isBookmarked
        self.storyDate = storyDate
    }
}
