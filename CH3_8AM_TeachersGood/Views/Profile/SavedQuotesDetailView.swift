//
//  SavedQuotesDetailView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 29/05/26.
//

import SwiftUI

struct SavedQuoteDetailView: View {
    let quote: AttributedString
    let author: String

    @State private var isBookmarked: Bool = true
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()

            // Quote
            VStack(alignment: .leading, spacing: 16) {
                Text(quote)
                    .font(.system(size: 40, design: .serif))
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Author
                Text("- \(author)")
                    .font(.system(size: 20, design: .serif))
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .trailing)

                // Actions
                HStack(spacing: 25) {
                    Button { } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 25))
                            .foregroundStyle(Color.appPrimary)
                    }
                    Button { isBookmarked.toggle() } label: {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark.slash")
                            .font(.system(size: 25))
                            .foregroundStyle(Color.appPrimary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }

            Spacer()
        }
        .padding(20)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

#Preview {
    SavedQuoteDetailView(quote: QuoteCard.sample, author: "Lorem")
}
