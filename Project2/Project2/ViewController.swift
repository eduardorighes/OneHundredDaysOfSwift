//
//  ViewController.swift
//  Project2
//
//  Created by Eduardo Maestri Righes on 11/05/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    var countries = [String]()
    var score = 0 {
        didSet {
            updateViewTitle()
        }
    }
    var correctAnswer = 0
    var countQuestions = 0
    
    static let totalQuestions = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += [
            "estonia",
            "france",
            "germany",
            "ireland",
            "italy",
            "monaco",
            "nigeria",
            "poland",
            "russia",
            "spain",
            "uk",
            "us"
        ]
        
        buttonsSetup()
        askQuestion(action: nil)
    }
    
    func buttonsSetup() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func updateViewTitle() {
        title = "Score: \(score) - Guess: \(countries[correctAnswer].uppercased())"
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        updateViewTitle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "That is the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        countQuestions += 1
        
        var message = ""
        let endGame = (countQuestions == ViewController.totalQuestions)

        if endGame {
            message = "You have answered \(countQuestions) questions\n"
        }
        message += "Your score is \(score)"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if endGame == false {
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        } else {
            let resetGameState = { (action: UIAlertAction!) -> Void in
                self.score = 0
                self.countQuestions = 0
                self.correctAnswer = 0
                self.askQuestion()
            }
            ac.addAction(UIAlertAction(title: "Play Again?", style: .default, handler: resetGameState))
        }
        present(ac, animated: true)
    }
    
}

