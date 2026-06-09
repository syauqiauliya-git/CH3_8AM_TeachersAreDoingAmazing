//
//  QuoteView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 26/05/26.
//

import SwiftUI
import SwiftData
import WidgetKit // Necessary for timeline invalidation

struct AffirmationsView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var affirmations: [Affirmation]
    @Query var teachers: [Teacher]
    
    var teacher: Teacher? { teachers.first }
    
    @State private var selectedAffirmation: Affirmation?
    @State private var showThingyTip: Bool = false
    @State private var tipTask: Task<Void, Never>? = nil
    @State private var tipIndex: Int = 0
    
    @State private var showHeartAnimation: Bool = false
    
    
    private let tips = [
        "Double tap to like!",
        "Connect your action button to Thingy through settings!",
        "You can add widgets!",
        "Thingy can suggest relevant articles!"
    ]
    
    var body: some View {
        ZStack {
            // Main Content
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
//                            .foregroundStyle(Color.appGradientPurpleStart)
                            .foregroundStyle(Color.appGradeBorder)
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle()) // Ensures the empty space registers the double tap
            .onTapGesture(count: 2) {
                // Triggers the heart animation in, then schedules it to animate out
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)) {
                    showHeartAnimation = true
                }
                
                Task {
                    try? await Task.sleep(for: .milliseconds(800))
                    withAnimation(.easeOut(duration: 0.3)) {
                        showHeartAnimation = false
                    }
                }
            }
            
            // NEW: The transient heart overlay
            if showHeartAnimation {
                Image(systemName: "heart.fill")
                    .font(.system(size: 150))
                    .foregroundStyle(Color.appGradientPurpleStart) // Adjust color as needed
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.5).combined(with: .opacity),
                        removal: .scale(scale: 1.2).combined(with: .opacity)
                    ))
                // Ignore touches so it doesn't interrupt ongoing interactions while fading
                    .allowsHitTesting(false)
            }
        }
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
//                        .foregroundStyle(Color.appGradientPurpleStart)
                        .foregroundStyle(Color.appGradeBorder)
                        .frame(width: 50, height: 50)
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
//                        .fill(Color.appGradientPurpleStart)
                        .fill(Color.appGradeBorder)
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
        .task {
            seedIfNeeded(context: modelContext)
            
//           Defer the selection and broadcasting to prevent SwiftData memory collisions
            try? await Task.sleep(for: .milliseconds(100))
            refreshIfNeeded()
            if let affirmation = selectedAffirmation {
                broadcastToWidget(affirmation: affirmation)
            }
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
    
    func refreshIfNeeded() {
        let interval = IntervalTime(rawValue: teacher?.affirmationInterval ?? "") ?? .onetime
        
        let lastShownAt = UserDefaults.standard.object(forKey: "lastShownAt") as? Date ?? Date.distantPast
        let currentSavedID = UserDefaults.standard.string(forKey: "currentAffirmationID") ?? ""
        
        let shouldChange = shouldRefresh(for: interval, last: lastShownAt)
        
        if shouldChange || currentSavedID.isEmpty {
            let next = affirmations.filter { $0.id.uuidString != currentSavedID }.randomElement() ?? affirmations.randomElement()
            
            if let next {
                let nextID = next.id.uuidString
                
                UserDefaults.standard.set(Date(), forKey: "lastShownAt")
                UserDefaults.standard.set(nextID, forKey: "currentAffirmationID")
                
                if let teacher {
                    teacher.lastShownAt = Date()
                    teacher.currentAffirmationID = nextID
                }
                
                selectedAffirmation = next
            }
        } else {
            selectedAffirmation = affirmations.first { $0.id.uuidString == currentSavedID } ?? affirmations.randomElement()
        }
    }
    
    func times(for interval: IntervalTime) -> [(hour: Int, minute: Int)] {
        switch interval {
        case .onetime:    return [(7, 30)]
        case .twotimes:   return [(7, 30), (16, 0)]
        case .threetimes: return [(7, 30), (12, 0), (18, 0)]
        case .fourtimes:  return [(7, 30), (10, 0), (13, 0), (16, 0)]
        }
    }
    
    func shouldRefresh(for interval: IntervalTime, last: Date) -> Bool {
        let now = Date()
        let calendar = Calendar.current
        
        let todaySlots = times(for: interval).map { slot in
            calendar.date(bySettingHour: slot.hour, minute: slot.minute, second: 0, of: now) ?? now
        }
        
        guard let mostRecentSlot = todaySlots.filter({ $0 <= now }).max() else {
            return false
        }
        
        return last < mostRecentSlot
    }
    
    private func broadcastToWidget(affirmation: Affirmation) {
        guard ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" else { return }
        
        // Extracting SwiftData relationships (like .tokens) must be handled carefully.
        let plainText = affirmation.tokens
            .sorted(by: { $0.order < $1.order })
            .map { $0.text }
            .joined(separator: " ")
        
        // Push the App Group and Widget update to a background task so it
        // doesn't block or crash the main UI thread during navigation.
        Task.detached {
            if let sharedDefaults = UserDefaults(suiteName: "group.com.Solaced") {
                sharedDefaults.set(plainText, forKey: "activeAffirmation")
                WidgetCenter.shared.reloadTimelines(ofKind: "SolaceWidget")
            }
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
        .preferredColorScheme(ColorScheme.dark)
}
