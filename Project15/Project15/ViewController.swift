//
//  ViewController.swift
//  Project15
//
//  Created by Eduardo Maestri Righes on 19/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView!
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }

    @IBAction func tapped(_ sender: UIButton) {
        sender.isHidden = true
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            print("animation")
            switch self.currentAnimation {
            case 0:
                break
            default:
                break
            }
        } completion: { finished in
            print("completion")
            sender.isHidden = false
        }
        
        print("current animation = \(currentAnimation)")
        currentAnimation = (currentAnimation + 1) % 8
    }
    
}

