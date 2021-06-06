//
//  ViewController.swift
//  Project1
//
//  Created by Eduardo Maestri Righes on 08/05/2021.
//

import UIKit

class ViewController: UICollectionViewController {

    var pictures = [String]()
    
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
            
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as? PictureCell else {
            fatalError("Cannot reuse PictureCell.")
        }
        
        let borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = borderColor
        cell.layer.cornerRadius = 7
        
        cell.imageName.text = pictures[indexPath.item]
        cell.imageView.image = UIImage(named: pictures[indexPath.item])
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.borderColor = borderColor
        cell.imageView.layer.cornerRadius = 3
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
            vc.imageIndex = indexPath.item
            vc.imageCount = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

