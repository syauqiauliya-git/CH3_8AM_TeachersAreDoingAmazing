//
//  IntervalEnum.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//

enum IntervalTime: String, CaseIterable, Identifiable {
    case onetime    = "Daily"
    case twotimes   = "Twice a day"
    case threetimes = "3 times a day"
    case fourtimes   = "4 times a day"

    var id: Self { self }
}
