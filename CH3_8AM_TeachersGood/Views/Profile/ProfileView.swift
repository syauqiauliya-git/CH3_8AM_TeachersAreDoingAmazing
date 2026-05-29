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
                HStack(alignment: .center, spacing: 12) {
                    MascotView(size: 150)
                    SpeechBubbleView(
                        text: "\nHi John!\nPersonalise your experience and revisit your saved inspirations.\n",
                        tail: .left
                    )
                    Spacer()
                }
                .padding(.horizontal, 24)
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
                            // add later
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
                    Section("Library") {
                        NavigationLink {
                            // add later
                        } label: {
                            HStack {
                                Text("Saved Quotes")
                                Spacer()
                                    .foregroundStyle(.secondary)
                            }
                        }
                        NavigationLink {
                            // add later
                        } label: {
                            HStack {
                                Text("Saved Stories")
                                Spacer()
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    Section("Preferences") {
                        NavigationLink {
                            // add later
                        } label: {
                            HStack {
                                Text("Light Mode")
                                Spacer()
                                Text("System Default")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}
