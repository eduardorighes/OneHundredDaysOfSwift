//
//  TableViewController.swift
//  Project4
//
//  Created by Eduardo Maestri Righes on 18/05/2021.
//

import UIKit

class TableViewController: UITableViewController {

    let websites = [
        "hackingwithswift.com",
        "apple.com"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Simple Browser"
        navigationItem.largeTitleDisplayMode = .always
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let webview = storyboard?.instantiateViewController(withIdentifier: "WebView") as? ViewController {
            webview.website = websites[indexPath.row]
            webview.allowedWebsites = websites
            navigationController?.pushViewController(webview, animated: true)
        }
    }

}
