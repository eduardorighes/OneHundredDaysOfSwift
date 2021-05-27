//
//  DetailViewController.swift
//  Project7
//
//  Created by Eduardo Maestri Righes on 26/05/2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        let htmlString = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            body { font-size: 150%; font-family: Arial; }
            #title { font-variant:small-caps; font-weight: bold; }
        </style>
        </head>
        <body>
        <p id="title">\(detailItem.title)</p>
        <hr/>
        <p>\(detailItem.body)</p>
        </body>
        </html>
        """
        
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
}
