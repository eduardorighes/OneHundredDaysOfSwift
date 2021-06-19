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
        //UIView.animate(withDuration: 1, delay: 0, options: []) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            print("animation")
            switch self.currentAnimation {
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                break
            case 1:
                self.imageView.transform = .identity
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
            case 3:
                self.imageView.transform = .identity
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                break
            case 5:
                self.imageView.transform = .identity
            case 6:
                self.imageView.alpha = 0.1
                self.imageView.backgroundColor = .green
                break
            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = .clear
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

