//
//  ContentView.swift
//  Orthodox Korea
//
//  Created by LeontG Music on 11/8/25.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var web = WebController(
        startURL: URL(string: "https://orthodoxkorea.org/")!,
        useEphemeralStore: false,   // set true if you never want persistent cache/cookies
        forceMobileOnPad: false     // set true if you prefer mobile view on iPad
    )

    var body: some View {
        ZStack {
            WebContainerView(webView: web.webView)
                .ignoresSafeArea()

            // Floating bottom toolbar
            VStack {
                Spacer()
                HStack(spacing: 24) {
                    // Home
                    Button {
                        web.goHome(clearBefore: true)
                    } label: {
                        Image(systemName: "house.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .shadow(radius: 3)
                            .accessibilityLabel("Home")
                    }

                    // Back
                    Button {
                        web.goBack()
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .shadow(radius: 3)
                            .accessibilityLabel("Back")
                    }
                    .disabled(!web.canGoBack)

                    // Reload
                    Button {
                        web.reload()
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .shadow(radius: 3)
                            .accessibilityLabel("Reload")
                    }

                    // Forward
                    Button {
                        web.goForward()
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .shadow(radius: 3)
                            .accessibilityLabel("Forward")
                    }
                    .disabled(!web.canGoForward)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.bottom, 24)
                .padding(.horizontal, 16)
            }
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background:
                web.clearWebsiteData()
            default:
                break
            }
        }
    }
}

#Preview {
    ContentView()
}
