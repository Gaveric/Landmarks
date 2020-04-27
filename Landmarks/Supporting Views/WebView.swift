//
//  File.swift
//  Landmarks
//
//  Created by User on 27.04.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: String
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL (string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest (url:url)
        let wkWebView = WKWebView()
        wkWebView.load (request)
        return wkWebView
    }
    
    func updateUIView(_ uiView: WebView.UIViewType, context: UIViewRepresentableContext<WebView>){
    }
    
}
