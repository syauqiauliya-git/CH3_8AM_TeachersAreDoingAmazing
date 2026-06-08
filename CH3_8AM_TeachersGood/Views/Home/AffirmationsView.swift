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
    @Query var teachers: [Teacher]
    
    var teacher: Teacher? { teachers.first }
    
    @State private var selectedAffirmation: Affirmation?
    @State private var showThingyTip: Bool = false
    
    var body: some View {
        VStack {
            
            HStack(alignment: .center) {
                
                Button(action: {
                    showThingyTip.toggle()
                    
                }) {
                    GifWebView(gifName: ThingyState.idle.mode)
                        .frame(width: 80, height: 80)
                        .padding(.trailing, 20)
                        .padding(.leading, 5)
                }
                
                Spacer()
                
                if showThingyTip {
                    SpeechBubbleView(text: "Double tap to like!", tail: .left, isThingyTip: true)
                        .transition(.opacity)
                }
                
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
            }
            .padding(.top, 35)
            
            
            Spacer()
            
            VStack(spacing: 20) {
                if let affirmation = selectedAffirmation {
                    Text(render(affirmation))
                        .font(.custom("Canela-Regular", size: 34))
                }
            }
            
            Spacer()
        }
        .padding(25)
        .background(Color.appBackground)
        .navigationBarBackButtonHidden(true)
        
        // 1. Explicitly hide the system navigation bar so it stops reserving invisible space
        .toolbar(.hidden, for: .navigationBar)
        
        // 2. Push the entire VStack up into the top physical boundary of the device
        .ignoresSafeArea(edges: .top)
        
        // You can remove the top toolbar background modifiers since the bar is now hidden
        .toolbarBackground(.visible, for: .bottomBar)
        .toolbarBackground(Color.appBackground, for: .bottomBar)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                NavigationLink {
                    ArticlesView()
                } label: {
                    Image(systemName: "book.pages")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.appGradientPurpleStart)
                }
                .buttonStyle(.plain)
            }
            ToolbarItem(placement: .bottomBar) { Spacer() }
            ToolbarItem(placement: .bottomBar) {
                NavigationLink {
                    MainVoiceInputView()
                } label: {
                    Circle()
                        .fill(Color.appGradientPurpleStart)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "ellipsis.message.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .onAppear {
            seedIfNeeded(context: modelContext)
            selectedAffirmation = affirmations.randomElement()
        }
    }
    
    func render(_ affirmation: Affirmation) -> AttributedString {
        var result = AttributedString()
        
        for token in affirmation.tokens.sorted(by: { $0.order < $1.order }) {
            var part = AttributedString(token.text + " ")
            
            switch token.style {
            case .normal: part.foregroundColor = .appTextBnW
            case .purple: part.foregroundColor = .purpleHighlight
            case .orange: part.foregroundColor = .orangeHighlight
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
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    
    let container = try! ModelContainer(
        for: Affirmation.self, AffirmationToken.self,
        configurations: config
    )
    
    let context = container.mainContext
    
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "You", style: .normal, order: 0),
            AffirmationToken(text: "are", style: .normal, order: 1),
            AffirmationToken(text: "capable", style: .purple, order: 2),
            AffirmationToken(text: "of", style: .normal, order: 3),
            AffirmationToken(text: "amazing", style: .orange, order: 4),
            AffirmationToken(text: "things.", style: .normal, order: 5)
        ])
    )
    
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "Progress", style: .purple, order: 0),
            AffirmationToken(text: "is", style: .normal, order: 1),
            AffirmationToken(text: "progress.", style: .purple, order: 2)
        ])
    )
    
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "Good", style: .normal, order: 0),
            AffirmationToken(text: "job!", style: .orange, order: 1),
            AffirmationToken(text: "You've", style: .normal, order: 2),
            AffirmationToken(text: "got", style: .orange, order: 3),
            AffirmationToken(text: "this!", style: .orange, order: 4)
        ])
    )
    
    return AffirmationsView()
        .modelContainer(container)
}
