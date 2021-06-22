//
//  CapitalInfoViewController.swift
//  Project16
//
//  Created by Eduardo Maestri Righes on 22/06/2021.
//

import UIKit
import WebKit

class CapitalInfoViewController: UIViewController {

    var webView: WKWebView!
    var capital: Capital?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let capital = capital else { return }
        guard let wikiURL = capital.wikiURL else { return }
        
        if let url = URL(string: wikiURL) {
            webView.load(URLRequest(url: url))
        }
    }

}
