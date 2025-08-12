//
//  WebView.swift
//  Orthodox Korea
//
//  Created by LeontG Music on 12/8/25.
//

import Foundation
import SwiftUI

import WebKit

struct Webview : UIViewRepresentable {


    let request: URLRequest
    var webview: WKWebView?

    init(web: WKWebView?, req: URLRequest) {
        self.webview = WKWebView()
        self.request = req
    }

    func getCustomUserAgent() -> String {
        #if targetEnvironment(macCatalyst)
        // Mac (Catalyst)
        return "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Safari/605.1.15"
        #else
        // iOS / iPadOS
        let device = UIDevice.current.userInterfaceIdiom
        switch device {
        case .phone:
            return "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1"
        case .pad:
            return "Mozilla/5.0 (iPad; CPU OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1"
        default:
            // Default fallback for others (TV, carPlay, unknown)
            return "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1"
        }
        #endif
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        return webview!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webview?.allowsBackForwardNavigationGestures = true
        webview?.customUserAgent = getCustomUserAgent()

        if webview?.url == nil {
            webview?.load(request)
        }
        uiView.load(request)
    }

    func goBack(){
        webview?.goBack()
    }

    func goForward(){
        webview?.goForward()
    }
    
    func reload(){
        webview?.reload()
    }
    
    func goHome(){
        webview?.load(URLRequest(url: URL(string: "https://orthodoxkorea.org/")!))
    }
  }
