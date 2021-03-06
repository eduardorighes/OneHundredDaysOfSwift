//
//  ViewController.swift
//  Project6b
//
//  Created by Eduardo Maestri Righes on 22/05/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()

        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWSOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        let viewDictionary = [
            "label1": label1,
            "label2": label2,
            "label3": label3,
            "label4": label4,
            "label5": label5
        ]
        
        for labelView in viewDictionary.values {
            view.addSubview(labelView)
        }
        
//        for labelName in viewDictionary.keys {
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(labelName)]|", options: [], metrics: nil, views: viewDictionary))
//        }
//
//        let metrics = [ "labelHeight": 88 ]
//
//        // @999 means priority 999, which is optional but high in the list.
//        // @1000 (default) must be met (required).
//        // Labels 2 to 5 must have the same height and priority of label 1.
//        // The last label must be 10 points or more from the bottom of the screen.
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: metrics, views: viewDictionary))
        
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            // code disabled for challenge 1
            //label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            // challenge 1 (goes over safe area)
            //label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            //label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

            // challenge 2 (does not go over safe area)
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
            if let previous = previous {
                // we have a previous label - create a height constraint
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            // challenge 3 - total height x multiplier + constant
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            
            // set the previous label to be the current one, for the next loop iteration
            previous = label
        }
    }
}

