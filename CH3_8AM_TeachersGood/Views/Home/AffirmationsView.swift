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
    @State private var tipTask: Task<Void, Never>? = nil
    @State private var tipIndex: Int = 0

    private let tips = [
        "Double tap to like!",
        "Connect your action button to Thingy through settings!",
        "You can add widgets!",
        "Thingy can suggest relevant articles!"
    ]
    
    var body: some View {
        VStack {
            
            HStack(alignment: .center) {
                
                Button(action: {
                    tipTask?.cancel()
                    
                    if showThingyTip {
                        withAnimation(.easeOut(duration: 0.3)) { showThingyTip = false }
                    } else {
                        tipIndex = (tipIndex + 1) % tips.count
                        withAnimation(.easeIn(duration: 0.15)) { showThingyTip = true }
                        tipTask = Task {
                            try? await Task.sleep(for: .seconds(2))
                            guard !Task.isCancelled else { return }
                            withAnimation(.easeOut(duration: 0.3)) { showThingyTip = false }
                        }
                    }
                }) {
                    GifWebView(gifName: ThingyState.idle.mode)
                        .frame(width: 80, height: 80)
                        .allowsHitTesting(false)
                }
                .frame(width: 80, height: 80)
                .contentShape(Rectangle())
                .padding(.trailing, 5)
                .padding(.leading, 5)
                .accessibilityLabel(Text("Mascot"))
                .accessibilityHint(Text("Tap to show a tip"))
                
                Spacer()
                
                if showThingyTip {
                    SpeechBubbleView(text: tips[tipIndex], tail: .left, isThingyTip: true)
                        .transition(.opacity)
                }
                
                NavigationLink {
                    ProfileView()
                } label: {
                    Image(systemName: "person")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.appGradientPurpleStart)
                }
                .frame(width: 50, height: 50)
                .buttonBorderShape(.circle)
                .buttonStyle(.glass)
                .controlSize(ControlSize.large)
                .padding(.leading, 15)
                
                .accessibilityLabel(Text("User Profile"))
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
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea(edges: .top)
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
                .accessibilityLabel(Text("Articles"))
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
                .accessibilityLabel(Text("Talk to thingy"))
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
