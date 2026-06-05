//
//  CH3_8AM_TeachersGoodApp.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 25/05/26.
//

import SwiftUI
import SwiftData

@main
struct CH3_8AM_TeachersGoodApp: App {
    @State private var showVoiceInput = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .fullScreenCover(isPresented: $showVoiceInput) {
                    MainVoiceInputView()
                }
                .onReceive(NotificationCenter.default.publisher(for: .openVoiceInput)) { _ in
                    showVoiceInput = true
                }
        }
        .modelContainer(for: [TeacherProfile.self, Affirmation.self])
    }
}
