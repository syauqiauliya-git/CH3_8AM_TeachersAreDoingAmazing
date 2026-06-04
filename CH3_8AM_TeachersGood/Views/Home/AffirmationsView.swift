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
                if let affirmation = selectedAffirmation {
                    Text(render(affirmation))
                }
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
            seedIfNeeded(context: modelContext)
            selectedAffirmation = affirmations.randomElement()
        }
    }
    
    func render(_ affirmation: Affirmation) -> AttributedString {
        var result = AttributedString()
        
        for token in affirmation.tokens {
            var part = AttributedString(token.text + " ")
            
            switch token.style {
            case .normal:
                part.foregroundColor = .primary
            case .purple:
                part.foregroundColor = .purple
            case .orange:
                part.foregroundColor = .orange
            }
            
            result += part
        }
        
        return result
    }
    
    func seedIfNeeded(context: ModelContext) {
        do {
            let existing = try context.fetch(FetchDescriptor<Affirmation>())
            
            guard existing.isEmpty else { return }
            
            for affirmation in AffirmationSeedData.all {
                context.insert(affirmation)
            }
            
            try context.save()
            
        } catch {
            print("Seeding error:", error)
        }
    }
    
    //    func showAffirmations() {
    //        let affirmationTexts = [
    //            "You are capable of amazing things.",
    //            "Every day is a new opportunity.",
    //            "You are stronger than you think.",
    //            "Progress is progress, no matter how small.",
    //            "You deserve kindness and patience."
    //        ]
    //
    //        do {
    //            let existing = try modelContext.fetch(FetchDescriptor<Affirmation>())
    //
    //            if existing.isEmpty {
    //                for text in affirmationTexts {
    //                    modelContext.insert(Affirmation(text: text))
    //                }
    //
    //                try modelContext.save()
    //            }
    //
    //            let allAffirmations = try modelContext.fetch(FetchDescriptor<Affirmation>())
    //            selectedAffirmation = allAffirmations.randomElement()
    //
    //        } catch {
    //            print("Error:", error)
    //        }
    //    }
}

//#Preview {
//    AffirmationsView()
//}

//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(
//        for: Affirmation.self,
//        configurations: config
//    )
//
//    let context = container.mainContext
//
//    context.insert(
//        Affirmation(text: "You are capable of amazing things.")
//    )
//
//    context.insert(
//        Affirmation(text: "Progress is progress.")
//    )
//
//    context.insert(
//        Affirmation(text: "Good job! You've got this!")
//    )
//
//    context.insert(
//        Affirmation(text: "The day has come to shine!")
//    )
//
//    return AffirmationsView()
//        .modelContainer(container)
//}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    
    let container = try! ModelContainer(
        for: Affirmation.self, AffirmationToken.self,
        configurations: config
    )
    
    let context = container.mainContext
    
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "You", style: .normal),
            AffirmationToken(text: "are", style: .normal),
            AffirmationToken(text: "capable", style: .purple),
            AffirmationToken(text: "of", style: .normal),
            AffirmationToken(text: "amazing", style: .orange),
            AffirmationToken(text: "things", style: .normal),
            AffirmationToken(text: ".", style: .normal)
        ])
    )
    
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "Progress", style: .purple),
            AffirmationToken(text: "is", style: .normal),
            AffirmationToken(text: "progress", style: .purple),
            AffirmationToken(text: ".", style: .normal)
        ])
    )
    
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "Good", style: .normal),
            AffirmationToken(text: "job", style: .orange),
            AffirmationToken(text: "!", style: .normal),
            AffirmationToken(text: "You’ve", style: .normal),
            AffirmationToken(text: "got", style: .orange),
            AffirmationToken(text: "this", style: .orange),
            AffirmationToken(text: "!", style: .normal)
        ])
    )
    
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "The", style: .normal),
            AffirmationToken(text: "day", style: .orange),
            AffirmationToken(text: "has", style: .normal),
            AffirmationToken(text: "come", style: .orange),
            AffirmationToken(text: "to", style: .normal),
            AffirmationToken(text: "shine", style: .purple),
            AffirmationToken(text: ".", style: .normal)
        ])
    )
    
    return AffirmationsView()
        .modelContainer(container)
}
