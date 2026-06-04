//
//  AppStates.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//

import Foundation

@Observable
class AppState {
    static let shared = AppState()
    var shouldOpenVoiceInput = false
}

extension Notification.Name {
    static let openVoiceInput = Notification.Name("openVoiceInput")
}
