//
//  CountryDetailViewController.swift
//  CountryFacts
//
//  Created by Eduardo Maestri Righes on 20/06/2021.
//

import UIKit

class CountryDetailViewController: UITableViewController {
    
    enum Fact {
        case name(_ name: String)
        case flag(_ flag: String)
        case language(_ language: String)
        case population(_ population: Int)
        case currency(_ currency: String)
        
        func fact() -> String {
            var result = ""
            switch self {
            case .name(let name):
                result = "Name: \(name)"
                break
            case .flag(let flag):
                result = "Flag: \(flag)"
                break
            case .language(let language):
                result = "Language: \(language)"
                break
            case .population(let population):
                result = "Population: \(population)"
                break
            case .currency(let currency):
                result = "Currency: \(currency)"
                break
            }
            return result
        }
    }

    var country: Country?
    var facts = [Fact]()
    
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
        
        facts = [
            .flag(country.flag),
            .language(country.language),
            .population(country.population),
            .currency(country.currency)
        ]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryFact")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryFact", for: indexPath)
        let fact = facts[indexPath.row]
        switch fact {
        case .flag:
//        case .flag(let flag):
//            let imageView = UIImageView(image: UIImage(contentsOfFile: flag))
//            imageView.contentMode = .scaleAspectFit
//            cell.contentView.addSubview(imageView)
            break
        default:
            cell.textLabel?.text = facts[indexPath.row].fact()
            break
        }
        return cell
    }
}
