//
//  ViewController.swift
//  Project7
//
//  Created by Eduardo Maestri Righes on 25/05/2021.
//

import UIKit

class ViewController: UITableViewController {

    var filteredPetitions = [Petition]()
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-info"), style: .plain, target: self, action: #selector(showCredits))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPetitions))
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    @objc func showCredits() {
        let credits = UIAlertController(title: "Credits", message: "The data used in the application comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        credits.addAction(UIAlertAction(title: "OK", style: .default))
        present(credits, animated: true)
    }
    
    @objc func searchPetitions() {
        let search = UIAlertController(title: "Search", message: nil, preferredStyle: .alert)
        search.addTextField()
        let searchAction = UIAlertAction(title: "Go", style: .default) { [weak self, weak search] _ in
            guard let text = search?.textFields?[0].text else { return }
            self?.search(text)
        }
        let clearAction = UIAlertAction(title: "Clear Search", style: .default) { [weak self] _ in
            self?.searchClear()
        }
        search.addAction(searchAction)
        search.addAction(clearAction)
        search.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(search, animated: true)
    }
    
    func searchClear() {
        filteredPetitions = petitions
        tableView.reloadData()
    }
    
    func search(_ text: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.filteredPetitions = []
            let lowercaseText = text.lowercased()
            for petition in self.petitions {
                if petition.title.lowercased().contains(lowercaseText) ||
                    petition.body.lowercased().contains(lowercaseText) {
                    self.filteredPetitions.append(petition)
                }
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        // decode the results array from json
        // jsonPetitions will have the decoded type
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }

    // MARK: - Table View Methods
    
    // For accessing petition data, use petitionSource which will select the correct data
    // to be displayed
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController()
        detail.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(detail, animated: true)
    }
}

