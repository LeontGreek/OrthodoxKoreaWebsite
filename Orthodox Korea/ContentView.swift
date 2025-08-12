//
//  ContentView.swift
//  Orthodox Korea
//
//  Created by LeontG Music on 11/8/25.
//

import SwiftUI

struct ContentView : View {


    let webview = Webview(web: nil, req: URLRequest(url: URL(string: "https://orthodoxkorea.org/")!))

    var body: some View {
        webview
            .ignoresSafeArea(.container, edges: [.bottom, .leading, .trailing])
        VStack{
            HStack(spacing: 40) {
                // Home
                Button(action: { self.webview.goHome()}){
                    Image(systemName: "house.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.yellow)
                        .shadow(radius: 3)
                }
                
                // Back
                Button(action: { self.webview.goBack() }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                        .shadow(radius: 3)
                }

                // Refresh
                Button(action: { self.webview.reload() }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                        .shadow(radius: 3)
                }

                // Forward
                Button(action: { self.webview.goForward() }) {
                    Image(systemName: "chevron.right.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                        .shadow(radius: 3)
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    ContentView()
}
