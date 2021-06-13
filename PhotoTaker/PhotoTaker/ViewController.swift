//
//  ViewController.swift
//  PhotoTaker
//
//  Created by Eduardo Maestri Righes on 12/06/2021.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PhotoTaker"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(takePhoto))
    }
    
    @objc func takePhoto() {
        let picker = createImagePicker()
        present(picker, animated: true)
    }
    
    //MARK: - image picker
    
    func createImagePicker() -> UIImagePickerController {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            fatalError("Could not retrieve image.")
        }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let photo = Photo(name: "New Photo", image: imageName)
        //photos.append(photo)
        photos.insert(photo, at: 0)
        tableView.reloadData()
        
        dismiss(animated: true)
    }

    //MARK: - table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as? PhotoCell else {
            fatalError("Cannot dequeue PhotoCell instance.")
        }
        cell.tableViewController = self
        cell.cellIndex = indexPath
                
        let photo = photos[indexPath.row]
        let imageURL = getDocumentsDirectory().appendingPathComponent(photo.image)
        
        cell.photo.image = UIImage(contentsOfFile: imageURL.path)
        cell.photo.layer.cornerRadius = 7
        cell.photo.layer.borderWidth = 2
        cell.photo.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor

        cell.label.text = photo.name
        
        
        return cell
    }

    //MARK: - helper methods
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}

