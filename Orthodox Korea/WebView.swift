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

    func makeUIView(context: Context) -> WKWebView  {
        return webview!
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
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
  }
