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
                    Section(header: Text("Personal")
                        .foregroundStyle(Color.appGradientPurpleStart)
                        .font(.custom("Futura", size: 18))
                    ) {
                        NavigationLink {
                            EditNameView()
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
                    }
                    Section(header: Text("Preferences")
                        .foregroundStyle(Color.appGradientPurpleStart)
                        .font(.custom("Futura", size: 18))
                    ) {
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
                            EditAffirmationFrequencyView()
                        } label: {
                            HStack {
                                Text("Affirmation Frequency")
                                Spacer()
                                Text("Daily")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    Section(header: Text("Privacy")
                        .foregroundStyle(Color.appGradientPurpleStart)
                        .font(.custom("Futura", size: 18))
                    ) {
                        NavigationLink {
                            // add later
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
