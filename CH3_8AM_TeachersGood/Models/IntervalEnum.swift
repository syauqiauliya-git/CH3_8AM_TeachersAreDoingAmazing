//
//  IntervalEnum.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//

enum IntervalTime: String, CaseIterable, Identifiable {
    case onetime    = "Daily"
    case twotimes   = "2 times/day"
    case threetimes = "3 times/day"
    case fourtimes   = "4 times/day"

    var id: Self { self }
}
