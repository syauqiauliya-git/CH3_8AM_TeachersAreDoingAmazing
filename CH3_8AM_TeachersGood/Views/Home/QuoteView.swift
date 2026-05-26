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
                    // action
                } label: {
                    Image(systemName: "person")
                        .foregroundStyle(Color.blue) // color of this will be changed
                }
                .frame(width: 50, height: 50)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .buttonBorderShape(.circle)
                .buttonStyle(.glass)
                .controlSize(ControlSize.large)
                Spacer()
                Text("“I want to change the future by educating younger generations.”")
                    .font(.system(size: 40, design: .serif))
                HStack {
                    Spacer()
                    Text("- Lorem")
                        .font(.system(size: 20, design: .serif))
                        .italic(true)
                }
                .padding(.trailing, 25)
                Spacer()
                NavigationLink {
                    // add later
                } label: {
                    Circle()
                        .fill(Color(red: 35/255, green: 39/255, blue: 144/255))
                        .frame(width: 50, height: 50)
                        .overlay(Image(systemName: "ellipsis.message.fill"))
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
            .padding(20)
        }
    }
}

#Preview {
    QuoteView()
}
