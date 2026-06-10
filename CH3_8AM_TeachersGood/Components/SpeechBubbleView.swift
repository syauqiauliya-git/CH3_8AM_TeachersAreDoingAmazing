//
//  SpeechBubbleView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

enum BubbleTail {
    case topLeft, topRight, bottomLeft, bottomRight, left, right
}

struct SpeechBubbleView: View {
    let text: String
    var tail: BubbleTail = .bottomLeft
    var isThingyTip: Bool = false
    
    // NEW: Optional variable to override the default width constraints
    var customMaxWidth: CGFloat? = nil
    
    // var to contain typing animation
    @State private var displayedText: String = ""
    
    var body: some View {
        Text(displayedText) // typing animation, originally Text(text)
            .dynamicTypeSize(...DynamicTypeSize.accessibility1)
            .font(.custom("Futura", size: isThingyTip ? 13 : 18))
            .foregroundColor(.appTextAlt)
            .opacity(0.75)
            .multilineTextAlignment(.leading)
            // Evaluates the custom width first; if nil, executes the default conditional sizing
            .frame(maxWidth: customMaxWidth ?? (isThingyTip ? 150 : 200), alignment: .leading)
            .padding(.horizontal, isThingyTip ? 10 : 20)
            .padding(.vertical, isThingyTip ? 10 : 20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.appSpeechBubble)
            )
            .overlay(alignment: tailAlignment) {
                TriangleTip()
                    .fill(Color.appSpeechBubble)
                    .frame(width: 16, height: 12)
                    .rotationEffect(tailRotation)
                    .offset(tailOffset)
            }
            .accessibilityLabel(Text("Thingy says, \(text)"))
        
            // added for typing animation
            .task(id: text) {
                await typeOutText()
            }
    }
    
    // added for typing animation
    private func typeOutText() async {
        displayedText = ""
        
        for character in text {
            displayedText.append(character)
            try? await Task.sleep(nanoseconds: 30_000_000)
        }
    }
    
    private var tailAlignment: Alignment {
        switch tail {
        case .topLeft:      .topLeading
        case .topRight:     .topTrailing
        case .bottomLeft:   .bottomLeading
        case .bottomRight:  .bottomTrailing
        case .left:         .leading
        case .right:        .trailing
        }
    }
    
    private var tailRotation: Angle {
        switch tail {
        case .topLeft, .topRight:       .degrees(180)
        case .bottomLeft, .bottomRight: .degrees(0)
        case .left:                     .degrees(90)
        case .right:                    .degrees(270)
        }
    }
    
    private var tailOffset: CGSize {
        let h: CGFloat = 20
        let v: CGFloat = 10
        switch tail {
        case .topLeft:     return CGSize(width:  h, height: -v)
        case .topRight:   return  CGSize(width: -h, height: -v)
        case .bottomLeft: return  CGSize(width:  h, height:  v)
        case .bottomRight: return CGSize(width: -h, height:  v)
        case .left:        return CGSize(width: -v, height: 0)
        case .right:       return CGSize(width:  v, height: 0)
        }
    }
}

struct TriangleTip: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

#Preview("Standard Width") {
    SpeechBubbleView(text: "Hey how's it going guys!", tail: .left, isThingyTip: false)
}

#Preview("Tip Width") {
    SpeechBubbleView(text: "Hey how's it going guys!", tail: .left, isThingyTip: true)
}

#Preview("Custom Override Width") {
    SpeechBubbleView(text: "This bubble ignores the default constraints entirely because a custom width was provided.", tail: .bottomLeft, customMaxWidth: 300)
}
