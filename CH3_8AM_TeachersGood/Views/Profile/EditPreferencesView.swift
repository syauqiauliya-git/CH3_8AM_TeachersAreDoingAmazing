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
    
    @AppStorage("appearanceMode") private var appearanceMode: String = AppearanceMode.system.rawValue
    
    @State private var selectedPreference: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(AppearanceMode.allCases, id: \.self) { mode in
                        Button {
                            appearanceMode = mode.rawValue
                        } label: {
                            HStack {
                                Text(mode.rawValue)
                                Spacer()
                                if appearanceMode == mode.rawValue {
                                    Image(systemName: "checkmark")
                                    //                                        .foregroundStyle(Color.appGradientPurpleStart)
                                        .foregroundColor(.appPrimaryLight)
                                        .font(.body.bold())
                                }
                            }
                        }
                        .foregroundStyle(.primary)
                        .listRowBackground(Color.appBackground)
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
