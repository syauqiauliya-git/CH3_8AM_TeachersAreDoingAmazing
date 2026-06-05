//
//  ProfileView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 29/05/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Personal") {
                        NavigationLink {
                            // add later
                        } label: {
                            HStack {
                                Text("Name")
                                Spacer()
                                Text("John")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        NavigationLink {
                            EditGradeView()
                        } label: {
                            HStack {
                                Text("Grade")
                                Spacer()
                                Text("Middle School")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        NavigationLink {
                            // add later
                        } label: {
                            HStack {
                                Text("Motivation")
                                Spacer()
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    Section("Preferences") {
                        NavigationLink {
                            EditPreferencesView()
                        } label: {
                            HStack {
                                Text("Appearance")
                                Spacer()
                                Text("Light Mode")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        NavigationLink {
                            // add later
                        } label: {
                            HStack {
                                Text("Affirmation Frequency")
                                Spacer()
                                Text("Daily")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    Section("Privacy") {
                        NavigationLink {
                            SavedQuotesView()
                        } label: {
                            HStack {
                                Text("Privacy & Policy")
                                Spacer()
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}
