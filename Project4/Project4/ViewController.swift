//
//  ViewController.swift
//  Project4
//
//  Created by Eduardo Maestri Righes on 16/05/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var allowedWebsites: [String]?
    var website: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        */
        
        let goBack = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: webView, action: #selector(webView.goBack))
        
        let goForward = UIBarButtonItem(image: UIImage(named: "forward"), style: .plain, target: webView, action: #selector(webView.goForward))
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progress = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progress, spacer, goBack, goForward, refresh]
        navigationController?.isToolbarHidden = false
        navigationItem.largeTitleDisplayMode = .never
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        if let website = website {
            let url = URL(string: "https://" + website)!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }

    /*
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    */
    
    func openPage(action: UIAlertAction) {
        guard let website = action.title else { return }
        guard let url = URL(string: "https://" + website) else { return }
        webView.load(URLRequest(url: url))
    }
    
    // MARK: - WKNavigationDelegate methods
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let allowed = allowedWebsites else {
            decisionHandler(.cancel)
            return
        }
        
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in allowed {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        if let urlForAction = url {
            print(urlForAction.absoluteString)
            // Hacky... first webView load is 'about:blank', which
            // triggers an alert. I don't want to show the alert in
            // that case.
            if (urlForAction.absoluteString != "about:blank") {
                let warning = UIAlertController(title: "Website Not Allowed", message: "This website is not in the allow list.", preferredStyle: .alert)
                warning.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                present(warning, animated: true)
            }
        }
        decisionHandler(.cancel)
    }
    
    // MARK: - KVO
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}

