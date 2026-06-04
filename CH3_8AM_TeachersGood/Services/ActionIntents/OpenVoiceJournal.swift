//
//  OpenVoiceJournal.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//

import AppIntents

struct OpenVoiceJournalIntent: AppIntent {
    static var title: LocalizedStringResource = "Talk to Thingy"
    static var description = IntentDescription("Open the voice journal")
    static var openAppWhenRun: Bool = true
    
    func perform() async throws -> some IntentResult {
        // Warm launch — app already running
        await MainActor.run {
            NotificationCenter.default.post(name: .openVoiceInput, object: nil)
        }
        // Cold launch — app not running
        UserDefaults.standard.set(true, forKey: "shouldOpenVoiceInput")
        return .result()
    }
}
