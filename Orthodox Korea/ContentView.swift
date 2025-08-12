//
//  ContentView.swift
//  Orthodox Korea
//
//  Created by LeontG Music on 11/8/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        webView.allowsBackForwardNavigationGestures = true

        // Pull-to-refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: .valueChanged)
        webView.scrollView.refreshControl = refreshControl

        context.coordinator.webView = webView
        context.coordinator.refreshControl = refreshControl

        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        weak var webView: WKWebView?
        weak var refreshControl: UIRefreshControl?

        @objc func handleRefresh() {
            webView?.reload()
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            refreshControl?.endRefreshing()
        }
    }
}

struct ContentView: View {
    let webView = WKWebView()

    var body: some View {
        ZStack {
            WebView(
                url: URL(string: "https://orthodoxkorea.org/")!,
                webView: webView
            )
            .ignoresSafeArea(.container, edges: [.bottom, .leading, .trailing])

            VStack {
                Spacer()
                HStack(spacing: 40) {
                    // Back
                    Button(action: { webView.goBack() }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                            .shadow(radius: 3)
                    }

                    // Refresh
                    Button(action: { webView.reload() }) {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                            .shadow(radius: 3)
                    }

                    // Forward
                    Button(action: { webView.goForward() }) {
                        Image(systemName: "chevron.right.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                            .shadow(radius: 3)
                    }
                }
                .padding(.bottom)
            }
        }
    }
}

#Preview {
    ContentView()
}
