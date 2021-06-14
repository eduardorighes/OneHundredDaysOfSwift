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
        
        if let photo = photo {
            title = photo.name
            let imageURL = getDocumentsDirectory().appendingPathComponent(photo.image)
            imageView.image = UIImage(contentsOfFile: imageURL.path)
        }
    }

}
