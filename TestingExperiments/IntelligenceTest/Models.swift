//
//  Models.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 25/05/26.
//



import SwiftData
import SwiftUI

@Model class TeacherProfile {
    var id: UUID = UUID()
    var gradeLevel: String = ""
    var generalFeeling: String = ""
    var coreMotivations: [String] = []
    var whyIStarted: String = ""
    var createdAt: Date = Date()
    
    @Relationship(deleteRule: .cascade) var journalEntries: [JournalEntry] = []
    @Relationship(deleteRule: .cascade) var dailyQuotes: [DailyQuote] = []
    
    init() {}
}

@Model class JournalEntry {
    var id: UUID = UUID()
    var transcript: String = ""
    var aiResponse: String = ""
    var recordedAt: Date = Date()
    var durationSeconds: Int = 0
    
    init() {}
}

@Model class DailyQuote {
    var id: UUID = UUID()
    var date: Date = Date()
    var quoteId: String = ""
    var personalizedText: String = ""
    
    init() {}
}

