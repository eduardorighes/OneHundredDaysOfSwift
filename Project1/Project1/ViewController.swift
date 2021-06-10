//
//  ViewController.swift
//  Project1
//
//  Created by Eduardo Maestri Righes on 08/05/2021.
//

import UIKit

class ViewController: UITableViewController {

    // I know I could have just a dictionary for everything
    // but I want to leave things separate in case I still
    // need to change this project
    var pictures = [String]()
    var imageViewCounter = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            // An iOS app always has a resourcePath,
            // so it is OK to force unwrap the value
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                    self?.pictures.append(item)
                }
            }
            self?.pictures.sort()
            
            self?.load()
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendApp))
    }
    
    @objc func recommendApp() {
        let recommendText = "I do recommend Project1 from 100 Days Of Swift! 👍"
        let vc = UIActivityViewController(activityItems: [recommendText], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func imageViewCount(forPath indexPath: IndexPath) -> Int {
        return imageViewCounter[pictures[indexPath.row]] ?? 0
    }
    
    func imageViewCount(forImage imageName: String) -> Int {
        return imageViewCounter[imageName] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "\(pictures[indexPath.row]) (\(imageViewCount(forPath: indexPath)) views)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageIndex = indexPath.row
            vc.imageCount = pictures.count
            navigationController?.pushViewController(vc, animated: true)
            let currentViewCounter = imageViewCounter[pictures[indexPath.row]] ?? 0
            imageViewCounter[pictures[indexPath.row]] = currentViewCounter + 1
            save()
            tableView.reloadData()
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(imageViewCounter) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "imageViewCounter")
        } else {
            print("Failed to encode data.")
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "imageViewCounter") as? Data {
            do {
                let jsonDecoder = JSONDecoder()
                imageViewCounter = try jsonDecoder.decode([String: Int].self, from: savedData)
            } catch {
                print("Failed to load data.")
            }
        }
    }
}

