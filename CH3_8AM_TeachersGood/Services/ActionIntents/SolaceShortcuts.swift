//
//  SolaceShortcuts.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//

import AppIntents


struct SolaceShortcuts: AppShortcutsProvider {
    
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenVoiceJournalIntent(),
            phrases: [
                "Talk to Thingy in \(.applicationName)",
                "Open \(.applicationName)"
            ],
            shortTitle: "Talk to Thingy",
            systemImageName: "mic.circle.fill"
        )
    }
}
