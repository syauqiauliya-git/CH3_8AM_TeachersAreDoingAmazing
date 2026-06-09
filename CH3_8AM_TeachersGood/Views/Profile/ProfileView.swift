//
//  ProfileView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 29/05/26.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query var teachers: [Teacher]
    
    var teacher: Teacher? { teachers.first }
    
    @AppStorage("appearanceMode") private var appearanceMode: String = AppearanceMode.system.rawValue
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: Text("Personal")
                            //                        .foregroundStyle(Color.appGradientPurpleStart)
                        .foregroundStyle(Color.appGradeBorder)
                        .font(.custom("Futura", size: 18))
                    ) {
                        NavigationLink {
                            EditNameView()
                        } label: {
                            HStack {
                                Text("Name")
                                Spacer()
                                Text(teacher?.name ?? "Not set")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        NavigationLink {
                            EditGradeView()
                        } label: {
                            HStack {
                                Text("Grade")
                                Spacer()
                                Text(teacher?.grade ?? "Not set")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .listRowBackground(Color.appBackground)
                    Section(header: Text("Preferences")
                            //                        .foregroundStyle(Color.appGradientPurpleStart)
                        .foregroundStyle(Color.appGradeBorder)
                        .font(.custom("Futura", size: 18))
                    ) {
                        NavigationLink {
                            EditPreferencesView()
                        } label: {
                            HStack {
                                Text("Appearance")
                                Spacer()
                                Text(appearanceMode)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        NavigationLink {
                            EditAffirmationFrequencyView()
                        } label: {
                            HStack {
                                Text("Affirmation Frequency")
                                Spacer()
                                Text(teacher?.affirmationInterval ?? "Not set")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .listRowBackground(Color.appBackground)
                    Section(header: Text("Privacy")
                            //                        .foregroundStyle(Color.appGradientPurpleStart)
                        .foregroundStyle(Color.appGradeBorder)
                        .font(.custom("Futura", size: 18))
                    ) {
                        NavigationLink {
                            PrivacyPolicyView()
                        } label: {
                            HStack {
                                Text("Privacy & Policy")
                                Spacer()
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .listRowBackground(Color.appBackground)
                }
                .scrollContentBackground(.hidden)
                .shadow(color: Color.appProfileShadow.opacity(0.4), radius: 10, x: 0, y: 4)
            }
            .background(Color.appBackground)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}
