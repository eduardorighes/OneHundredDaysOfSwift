//
//  ViewController.swift
//  Project10
//
//  Created by Eduardo Maestri Righes on 03/06/2021.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Could not dequeue a PersonCell.")
        }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let imagePath = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: imagePath.path)
        
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Person", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Rename...", style: .default) { [weak self] _ in
            let renameController = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
            renameController.addTextField()
            renameController.addAction(UIAlertAction(title: "OK", style: .default) { [weak renameController] _ in
                guard let newName = renameController?.textFields?[0].text else { return }
                if !newName.isEmpty {
                    person.name = newName
                    self?.collectionView.reloadData()
                }
            })
            renameController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(renameController, animated: true)
        })
        ac.addAction(UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            guard let person = self?.people[indexPath.item] else {
                fatalError("Trying to delete an item that does not exist.")
            }
            self?.people.remove(at: indexPath.item)
            if let imagePath = self?.getDocumentsDirectory().appendingPathComponent(person.image) {
                try? FileManager.default.removeItem(atPath: imagePath.path)
            }
            self?.collectionView.reloadData()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func addNewPerson() {
                
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let ac = UIAlertController(title: "Select a picture", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                guard let picker = self?.imagePicker(sourceType: .camera) else {
                    fatalError("Camera source not available")
                }
                self?.present(picker, animated: true)
            })
            ac.addAction(UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
                guard let picker = self?.imagePicker(sourceType: .photoLibrary) else {
                    fatalError("Photo Library source not available")
                }
                self?.present(picker, animated: true)
            })
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        } else {
            guard let picker = imagePicker(sourceType: .photoLibrary) else {
                fatalError("Photo Library source not available")
            }
            present(picker, animated: true)
        }
    }
    
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController? {
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            return nil
        }
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = sourceType
        
        return picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

