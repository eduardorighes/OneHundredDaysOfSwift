//
//  ViewController.swift
//  ProjectConsolidationOneToThree
//
//  Created by Eduardo Maestri Righes on 15/05/2021.
//

import UIKit

class ViewController: UITableViewController {

    var flags: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFlags()
    }
    
    func loadFlags() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let paths = try! fm.contentsOfDirectory(atPath: path)
        for path in paths {
            if path.hasSuffix("@2x.png") {
                flags.append(path)
            }
        }
        flags.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row]
        let flagImage = UIImage(named: flags[indexPath.row])
        cell.imageView?.image = flagImage
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else {
            let message = "Could not create image details view. Sorry."
            let alert = UIAlertController(title: "Flag Details", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        vc.imageName = flags[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

