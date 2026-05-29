//
//  SavedQuotesView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 29/05/26.
//

import SwiftUI

struct SavedQuotesView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // Dummy data for hifi
    let quotes: [AttributedString] = Array(repeating: QuoteCard.sample, count: 8)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<quotes.count, id: \.self) { index in
                    NavigationLink {
                        SavedQuoteDetailView(quote: quotes[index], author: "Lorem")
                    } label: {
                        QuoteCard(quote: quotes[index])
                            .frame(width: 160, height: 160)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Saved Quotes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Select") { }
                    .foregroundColor(.appTextPrimary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SavedQuotesView()
    }
}
