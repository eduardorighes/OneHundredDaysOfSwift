//
//  PhotoCell.swift
//  PhotoTaker
//
//  Created by Eduardo Maestri Righes on 13/06/2021.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet var photo: UIImageView!
    @IBOutlet var label: UILabel!
    
    var tableViewController: ViewController?
    var cellIndex: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(labelTap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        guard let controller = tableViewController else { return }
        guard let index = cellIndex else { return }
        
        let ac = UIAlertController(title: "Add a description", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            if let text = ac?.textFields?[0].text {
                controller.photos[index.row].name = text
                self?.label.text = text
            }
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        controller.present(ac, animated: true)
    }

}
