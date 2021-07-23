//
//  DetailViewController.swift
//  PhotoTaker
//
//  Created by Eduardo Maestri Righes on 14/06/2021.
//

import UIKit

class DetailViewController: UIViewController {

    var photo: Photo?
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photo = photo else { return }
        
        title = photo.name
        imageView.image = fetch(image: photo.image)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(activityTapped))
    }
    
    func fetch(image name: String) -> UIImage? {
        let imageURL = getDocumentsDirectory().appendingPathComponent(name)
        return UIImage(contentsOfFile: imageURL.path)
    }
    
    @objc func activityTapped() {
        guard let photo = photo else { return }
        guard let image = fetch(image: photo.image) else { return }
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: [])
        activity.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activity, animated: true)
    }

}
