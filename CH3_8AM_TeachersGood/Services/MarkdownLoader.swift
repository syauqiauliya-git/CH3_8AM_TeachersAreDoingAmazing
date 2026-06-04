//
//  MarkdownLoader.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 04/06/26.
//
import Foundation

enum MarkdownLoader {
    static func load(_ name: String) -> String {
        guard let url = Bundle.main.url(forResource: name, withExtension: "md") else {
            return "File not found"
        }
        
        return (try? String(contentsOf: url, encoding: .utf8)) ?? "Failed to load file"
    }
}
