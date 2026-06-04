//
//  MascotView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

enum ThingyMode: String, Identifiable {
    case normal    = "Thingy"
    case blink   = "ThingyBlink"
    
    var id: Self { self }
}


struct MascotView: View {
    var size: CGFloat = 150
    var currentMode: ThingyMode = .normal
    
    var body: some View {
        Image(currentMode.rawValue)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

#Preview {
    MascotView()
}
