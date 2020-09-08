//
//  WebView.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 11.07.20.
//

import SwiftUI
import Combine
import WebKit

struct WebView: UIViewRepresentable {
    
    @Binding var url: URL?
    @Binding var progress: Double
    @Binding var isLoading: Bool
    
    let navigator: PassthroughSubject<WebURL, Never>
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        // Enable javascript in WKWebView to interact with the web app
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
//        let coordinator = self.makeCoordinator()
//        configuration.userContentController.add(coordinator, name: ClickEvent.messageName)
        configuration.preferences = preferences
        configuration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_16) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Safari/605.1.15"
        
        webView.publisher(for: \.url)
            .receive(on: RunLoop.main)
            .sink { url in
                self.url = url
            }
            .store(in: &context.coordinator.cancellables)
        
        webView.publisher(for: \.estimatedProgress)
            .receive(on: RunLoop.main)
            .sink { progress in
                withAnimation {
                    self.progress = progress
                }
            }
            .store(in: &context.coordinator.cancellables)

        webView.publisher(for: \.isLoading)
            .receive(on: RunLoop.main)
            .sink { isLoading in
                let delay = isLoading ? 0 : 0.5
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation {
                        self.isLoading = isLoading
                    }
                }
            }
            .store(in: &context.coordinator.cancellables)
            
        navigator.receive(on: RunLoop.main).sink { url in
            switch url {
            case .localResource(let resourceName):
                if let url = Bundle.main.url(forResource: resourceName, withExtension: "html") {
                    webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
                }
            case .online(let url):
                var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
                request.allowsCellularAccess = true
                request.httpShouldHandleCookies = false
                webView.stopLoading()
                webView.load(URLRequest(url: url))
            }
        }
            .store(in: &context.coordinator.cancellables)
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: WebView
        var cancellables: [AnyCancellable] = []
        
        init(_ uiWebView: WebView) {
            self.parent = uiWebView
        }
        
        deinit {
            cancellables.forEach { $0.cancel() }
        }
    }
}
