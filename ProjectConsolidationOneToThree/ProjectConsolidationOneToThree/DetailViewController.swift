//
//  DetailViewController.swift
//  ProjectConsolidationOneToThree
//
//  Created by Eduardo Maestri Righes on 16/05/2021.
//

import UIKit

class DetailViewController: UIViewController {

    var imageName: String?
    @IBOutlet var imageView: UIImageView!
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Flag Details", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let name = imageName else {
            showError(message: "This view does not have an image name.")
            return
        }
        
        title = name
        imageView.image = UIImage(named: name)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor

        // TODO: need to add a border to the image
        // TODO: currently the imageView is full screen so imageView.layer.border*
        // TODO: will not result create a border at the correct location (just around the flag)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionTapped))
    }
    
    @objc func actionTapped() {
        guard let image = imageView.image else {
            showError(message: "This view does not have an image.")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
