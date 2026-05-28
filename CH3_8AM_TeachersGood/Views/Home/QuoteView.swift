//
//  QuoteView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 26/05/26.
//

import SwiftUI

struct QuoteView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    // add later
                } label: {
                    Image(systemName: "person")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.appPrimary)
                }
                .frame(width: 50, height: 50)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .buttonBorderShape(.circle)
                .buttonStyle(.glass)
                .controlSize(ControlSize.large)
                Spacer()
                VStack {
                    Text("“I want to change the future by educating younger generations.”")
                        .font(.system(size: 40, design: .serif))
                    HStack {
                        Spacer()
                        Text("- Lorem")
                            .font(.system(size: 20, design: .serif))
                            .italic(true)
                    }
                    .padding(.trailing, 25)
                    HStack(spacing: 20) {
                        Button {
                            // add later
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 20))
                                .foregroundStyle(Color.appPrimary)
                        }
                        .frame(width: 50, height: 50)
                        .buttonBorderShape(.circle)
                        .buttonStyle(.glass)
                        .controlSize(ControlSize.large)
                        Button {
                            // add later
                        } label: {
                            Image(systemName: "bookmark")
                                .font(.system(size: 20))
                                .foregroundStyle(Color.appPrimary)
                        }
                        .frame(width: 50, height: 50)
                        .buttonBorderShape(.circle)
                        .buttonStyle(.glass)
                        .controlSize(ControlSize.large)
                    }
                }
                Spacer()
                HStack {
                    NavigationLink {
                        ArticlesView()
                    } label: {
                        Image(systemName: "book.pages")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.appPrimary)
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
                            .fill(Color.appPrimary)
                            .frame(width: 50, height: 50)
                            .overlay(Image(systemName: "ellipsis.message.fill"))
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                }
            }
            .padding(20)
        }
    }
}

#Preview {
    QuoteView()
}
