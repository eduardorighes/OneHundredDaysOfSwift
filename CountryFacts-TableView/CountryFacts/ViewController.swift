//
//  ViewController.swift
//  CountryFacts
//
//  Created by Eduardo Maestri Righes on 20/06/2021.
//

import UIKit

class ViewController: UITableViewController {

    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func loadData() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let dataURL = Bundle.main.url(forResource: "countries", withExtension: "json") else { return }
            guard let storedData = try? Data(contentsOf: dataURL) else { return }
            let encoder = JSONDecoder()
            if let jsonData = try? encoder.decode(Countries.self, from: storedData) {
                self?.countries = jsonData.countries
            } else {
                fatalError("Failed to decode countries data.")
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    //MARK: - table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = CountryDetailViewController()
        detail.country = countries[indexPath.row]
        navigationController?.pushViewController(detail, animated: true)
    }
}

