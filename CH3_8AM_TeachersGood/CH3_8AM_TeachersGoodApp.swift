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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .modelContainer(for: TeacherProfile.self)
        .modelContainer(for: [Affirmation.self, Story.self, TeacherProfile.self])
    }
}
