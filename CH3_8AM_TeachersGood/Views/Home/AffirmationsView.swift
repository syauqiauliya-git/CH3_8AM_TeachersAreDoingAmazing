//
//  QuoteView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 26/05/26.
//

import SwiftUI
import SwiftData

struct AffirmationsView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var affirmations: [Affirmation]
    
    @State private var selectedAffirmation: Affirmation?
    @State private var isBookmarked: Bool = false
    
    //    var mainQuote: AttributedString {
    //        var result = AttributedString("“I want to change the future by educating younger generations.”")
    //
    //        if let range = result.range(of: "change the future") {
    //            result[range].foregroundColor = .appMascotOrange
    //        }
    //
    //        if let range = result.range(of: "educating") {
    //            result[range].foregroundColor = .appPrimaryLight
    //        }
    //
    //        return result
    //    }
    
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
                //                Text(mainQuote)
                Text(selectedAffirmation?.text ?? "Loading...")
                    .font(.system(size: 40, design: .serif))
                Button {
                    isBookmarked.toggle()
                } label: {
                    Image(systemName: isBookmarked ? "heart.fill" : "heart")
                        .font(.system(size: 25))
                        .foregroundStyle(Color.appPrimaryLight)
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.glass)
                .controlSize(ControlSize.large)
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
                .controlSize(ControlSize.regular)
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
            selectedAffirmation = affirmations.randomElement()
        }
        .padding(20)
        .navigationBarBackButtonHidden(true)
    }
    
    func showAffirmations() {
        let affirmationTexts = [
            "You are capable of amazing things.",
            "Every day is a new opportunity.",
            "You are stronger than you think.",
            "Progress is progress, no matter how small.",
            "You deserve kindness and patience."
        ]
        
        do {
            let existing = try modelContext.fetch(FetchDescriptor<Affirmation>())
            
            if existing.isEmpty {
                for text in affirmationTexts {
                    modelContext.insert(Affirmation(text: text))
                }
                
                try modelContext.save()
            }
            
            let allAffirmations = try modelContext.fetch(FetchDescriptor<Affirmation>())
            selectedAffirmation = allAffirmations.randomElement()
            
        } catch {
            print("Error:", error)
        }
    }
}

//#Preview {
//    AffirmationsView()
//}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Affirmation.self,
        configurations: config
    )
    
    let context = container.mainContext
    
    context.insert(
        Affirmation(text: "You are capable of amazing things.")
    )
    
    context.insert(
        Affirmation(text: "Progress is progress.")
    )
    
    context.insert(
        Affirmation(text: "Good job! You've got this!")
    )
    
    return AffirmationsView()
        .modelContainer(container)
}
