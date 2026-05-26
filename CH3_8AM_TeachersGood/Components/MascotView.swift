//
//  MascotView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct MascotView: View {
    var size: CGFloat = 150

    var body: some View {
        Image("Thingy")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

#Preview {
    MascotView()
}
