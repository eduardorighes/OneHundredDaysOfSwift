//
//  CountryDetailViewController.swift
//  CountryFacts
//
//  Created by Eduardo Maestri Righes on 20/06/2021.
//

import UIKit
import WebKit

class CountryDetailViewController: UIViewController {

    var webView: WKWebView!
    var country: Country?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let country = country else { return }
        
        title = country.name
        
        let htmlString = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            body { font-family: Arial; }
            img { width: 100%; height: auto; }
            #name { font-size: 150%; font-variant:small-caps; font-weight: bold; }
        </style>
        </head>
        <body>
        <img src="\(country.flag)"/>
        <p>Language: \(country.language)</p>
        <p>Population: <span id="population">\(country.population)</span></p>
        <p>Currency Code: \(country.currency). Example: <span id="currency">123.99</span>.</p>
        
        <script>
        try {
            var pop = parseInt(document.getElementById("population").innerHTML);
            var formattedPop = pop.toLocaleString('en');
            document.getElementById("population").innerHTML = formattedPop;
        
            var cur = parseFloat(document.getElementById("currency").innerHTML);
            var formattedCur = cur.toLocaleString('\(country.locale)', {style: 'currency', currency: '\(country.currency)'});
            document.getElementById("currency").innerHTML = formattedCur;
        } catch (err) {
            alert("Script error: " + err.message);
        }
        </script>
        </body>
        </html>
        """
        
        webView.loadHTMLString(htmlString, baseURL: nil)
    }

}
