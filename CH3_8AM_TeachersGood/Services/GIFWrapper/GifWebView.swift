//
//  GifWebView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 05/06/26.
//

import SwiftUI
import WebKit

struct GifWebView: UIViewRepresentable {
    let gifName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = .clear
        webView.isOpaque = false // Keeps the background transparent
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Locate the GIF file inside the main app bundle
        if let bundleURL = Bundle.main.url(forResource: gifName, withExtension: "gif") {
            do {
                let data = try Data(contentsOf: bundleURL)
                uiView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: bundleURL.deletingLastPathComponent())
            } catch {
                print("Error loading GIF data: \(error)")
            }
        }
    }
}
