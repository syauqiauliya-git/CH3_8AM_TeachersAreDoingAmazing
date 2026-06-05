//
//  AffirmationToken.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 04/06/26.
//

import Foundation
import SwiftData

@Model
class AffirmationToken {
    var text: String
    var style: HighlightStyle
    var order: Int
    
    init(text: String = "", style: HighlightStyle = .normal, order: Int = 0) {
        self.text = text
        self.style = style
        self.order = order
    }
}
