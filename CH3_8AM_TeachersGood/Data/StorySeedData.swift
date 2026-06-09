//
//  StorySeedData.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 09/06/26.
//

import SwiftUI

private func makeDate(_ year: Int, _ month: Int, _ day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return Calendar.current.date(from: components) ?? Date()
}

enum StorySeedData {
    
    static let all: [Story] = [
        
        Story(
            labels: ["inspiration", "student impact"],
            title: "Inspirational Teachers: Teaching Award Winners Share Who Made an Impact on Them",
            mdFileName: "inspirational-teachers-teaching-award",
            image: "inspirational-teachers-teaching",
            summary: "In 2020, several recipients of the Lifetime Achievement Silver Teaching...",
            isBookmarked: false,
            storyDate: makeDate(2020, 10, 06)
        ),
        
        Story(
            labels: ["work-life balance", "sacrifice"],
            title: "A Rare Dedication to Education",
            mdFileName: "rare-dedication",
            image: "a-rare-dedication",
            summary: "In Barangay Tabangao Ambulong, Batangas, one teacher's story demonstrates the...",
            isBookmarked: false,
            storyDate: makeDate(2023, 09, 12)
        ),
        
        Story(
            labels: ["overcoming difficulties", "student impact"],
            title: "Beyond Chalk and Talk",
            mdFileName: "beyond-chalk-and-talk",
            image: "beyond-chalk",
            summary: "For Elgie Radaza, education is more than teaching lessons in a...",
            isBookmarked: false,
            storyDate: makeDate(2023, 10, 05)
        ),
        
        Story(
            labels: ["inspiration", "student impact"],
            title: "Inspired by a Grandfather's Legacy",
            mdFileName: "inspired-by-a-grandfathers-legacy",
            image: "inspired-by-grandfather",
            summary: "Growing up in a family of educators, one teacher found her...",
            isBookmarked: false,
            storyDate: makeDate(2021, 08, 31)
        ),
        
        Story(
            labels: ["overcoming difficulties"],
            title: "A Hope in Every Click of a Waning Finger",
            mdFileName: "a-hope-in-every-click",
            image: "story-placeholder",
            summary: "When schools across the Philippines were forced to adapt to new...",
            isBookmarked: false,
            storyDate: makeDate(2020, 07,14)
        ),
        
        Story(
            labels: ["curiosity", "student impact"],
            title: "Following Curiosity: From Architecture to Teaching",
            mdFileName: "following-curiosity-from-architecture",
            image: "story-placeholder",
            summary: "Although she began her professional life as an architect, one...",
            isBookmarked: false,
            storyDate: makeDate(2021, 08, 31)
        ),
        
        Story(
            labels: ["student impact", "tsr"],
            title: "Caring for Little Hearts",
            mdFileName: "caring-for-little-hearts",
            image: "story-placeholder",
            summary: "As a child, she dreamed of becoming either a doctor or...",
            isBookmarked: false,
            storyDate: makeDate(2021, 08, 31)
        )
    ]
}
