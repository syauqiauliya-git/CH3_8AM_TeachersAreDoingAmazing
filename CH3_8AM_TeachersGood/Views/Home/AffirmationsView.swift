//
//  QuoteView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 26/05/26.
//

import SwiftUI
import SwiftData

struct AffirmationsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var affirmations: [Affirmation]
    @State private var selected: Affirmation?
    
    @State private var isBookmarked: Bool = false
    
    var mainQuote: AttributedString {
        var result = AttributedString("“I want to change the future by educating younger generations.”")
        
        if let range = result.range(of: "change the future") {
            result[range].foregroundColor = .appMascotOrange
        }
        
        if let range = result.range(of: "educating") {
            result[range].foregroundColor = .appPrimaryLight
        }
        
        return result
    }
    
    var body: some View {
            VStack {
                NavigationLink {
                    ProfileView()
                } label: {
                    Image(systemName: "person")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.appPrimaryLight)
                }
                .frame(width: 50, height: 50)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .buttonBorderShape(.circle)
                .buttonStyle(.glass)
                .controlSize(ControlSize.large)
                Spacer()
                VStack(spacing: 20) {
                    Text("Count: \(affirmations.count)")

                        ForEach(affirmations) { affirmation in
                            Text(affirmation.text)
                        }
                    Text(mainQuote)
                        .font(.system(size: 40, design: .serif))
                    HStack {
                        Spacer()
                        Text("- Lorem")
                            .font(.system(size: 20, design: .serif))
                            .italic(true)
                    }
                    .padding(.trailing, 25)
                    HStack(spacing: 25) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 25))
                            .foregroundStyle(Color.appPrimaryLight)
                        Button {
                            isBookmarked.toggle()
                        } label: {
                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                .font(.system(size: 25))
                                .foregroundStyle(Color.appPrimaryLight)
                        }
                    }
                }
                Spacer()
                HStack {
                    NavigationLink {
                        ArticlesView()
                    } label: {
                        Image(systemName: "book.pages")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.appPrimaryLight)
                    }
                    .frame(width: 50, height: 50)
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    .buttonBorderShape(.circle)
                    .buttonStyle(.glass)
                    .controlSize(ControlSize.large)
                    Spacer()
                    NavigationLink {
                        MainVoiceInputView()
                    } label: {
                        Circle()
                            .fill(Color.appPrimaryLight)
                            .frame(width: 50, height: 50)
                            .overlay(Image(systemName: "ellipsis.message.fill"))
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                }
            }
            .onAppear {
                seedIfNeeded()

                if selected == nil {
                    selected = affirmations.randomElement()
                }
            }
//            .onChange(of: affirmations) {
//                selected = affirmations.randomElement()
//            }
//            .onAppear {
//                seedIfNeeded()
//            }
            .padding(20)
            .navigationBarBackButtonHidden(true)
    }
    
    private func seedIfNeeded() {
        let samples = [
            "You are capable of amazing things.",
            "Every day is a new opportunity.",
            "You are stronger than you think.",
            "Progress is progress, no matter how small.",
            "You deserve kindness and patience."
        ]

        do {
            let existing = try modelContext.fetch(FetchDescriptor<Affirmation>())

            if existing.isEmpty {
                for text in samples {
                    modelContext.insert(Affirmation(text: text))
                }

                try modelContext.save()
            }

            let allAffirmations = try modelContext.fetch(FetchDescriptor<Affirmation>())
            selected = allAffirmations.randomElement()

        } catch {
            print("Error:", error)
        }
    }
    
//    private func seedIfNeeded() {
//        guard affirmations.isEmpty else { return }
//
//        let samples = [
//            "You are capable of amazing things.",
//            "Progress is still progress.",
//            "You are stronger than you think.",
//            "Small steps still move forward.",
//            "You deserve kindness."
//        ]
//
//        for text in samples {
//            modelContext.insert(Affirmation(text: text))
//        }
//
//        try? modelContext.save()
//    }
}

#Preview {
    AffirmationsView()
}
