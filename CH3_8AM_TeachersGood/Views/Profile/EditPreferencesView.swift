//
//  EditPreferencesView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 03/06/26.
//

import SwiftUI

struct Preferences: Identifiable {
    let id = UUID()
    let name: String
}

struct EditPreferencesView: View {
    let preferences = [
        Preferences(name: "Light Mode"),
        Preferences(name: "Dark Mode"),
        Preferences(name: "System Default")
    ]
    
    @State private var selectedPreference: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                List(preferences) { preference in
                    HStack {
                        Text(preference.name)
                        Spacer()
                        if selectedPreference == preference.id {
                            Image(systemName: "checkmark")
                                .foregroundColor(.appPrimaryLight)
                                .font(.body.bold())
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedPreference = preference.id
                    }
                }
                .scrollContentBackground(.hidden)
                .shadow(color: Color.appProfileShadow.opacity(0.4), radius: 10, x: 0, y: 4)
            }
            .background(Color.appBackground)
            .navigationTitle("Preferences")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EditPreferencesView()
}
