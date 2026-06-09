//
//  ContentView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 25/05/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    @Query var teachers: [Teacher]
    
    var body: some View {
        Group {
            if hasCompletedOnboarding {
                NavigationStack {
                    AffirmationsView()
                }
            } else {
                WelcomeView()
            }
        }
        .onAppear {
            if !teachers.isEmpty {
                hasCompletedOnboarding = true
            }
        }
    }
}

#Preview {
    ContentView()
}
