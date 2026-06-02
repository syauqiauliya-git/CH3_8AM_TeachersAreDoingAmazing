//
//  SliderView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct SliderView: View {
    @State private var sliderPercentage = 0.0
    
    var body: some View {
        GeometryReader { proxy in
            let inset: CGFloat = 5
            let circleSize = proxy.size.height
            let travelWidth = proxy.size.width - inset * 2 - circleSize
            let innerWidth = proxy.size.width - inset * 2
            
            ZStack(alignment: .leading) {
                
                // Track background
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 40)
                    .foregroundStyle(Color.appSliderBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.appSliderBorder, lineWidth: 1)
                    )
                
//                // Filled portion
//                RoundedRectangle(cornerRadius: 25)
//                    .frame(width: innerWidth * sliderPercentage, height: 30)
//                    .foregroundStyle(Color.appPrimaryLight)
//                    .offset(x: inset)
//                
                // Indicator
                Circle()
                    .fill(Color.appGradeSelectedText)
                    .frame(height: circleSize)
                    .offset(x: inset + travelWidth * sliderPercentage)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        sliderPercentage = max(0, min(1, (value.location.x - inset) / innerWidth))
                    }
            )
        }
        .frame(height: 30)
        .padding(.horizontal, 30)
    }
}

#Preview {
    SliderView()
}
