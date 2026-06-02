//
//  QuoteCardView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 29/05/26.
//

import SwiftUI

struct QuoteCard: View {
    let quote: AttributedString

    var body: some View {
        Text(quote)
            .font(.system(size: 16, weight: .semibold))
            .multilineTextAlignment(.center)
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }
}

#Preview {
    QuoteCard(quote: QuoteCard.sample)
        .frame(width: 160, height: 200)
        .padding()
}

extension QuoteCard {
    static var sample: AttributedString {
        var str = AttributedString("\"I want to change the future by educating younger generations.\"")

        // Color rangges for hifi preview
        if let range = str.range(of: "change the future") {
            str[range].foregroundColor = .appMascotOrange
        }
        if let range = str.range(of: "educating") {
            str[range].foregroundColor = .appPrimaryLight
        }

        return str
    }
}
