//
//  NameInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct NameInputView: View {
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Text("1 of 4")
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            
            Spacer()

            
            Text("How would you like to be called?")
            MascotView()
            
            Spacer()

            
        }
    }
   
}

#Preview {
    NameInputView()
}
