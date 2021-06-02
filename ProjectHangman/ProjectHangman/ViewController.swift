//
//  ViewController.swift
//  ProjectHangman
//
//  Created by Eduardo Maestri Righes on 02/06/2021.
//

import UIKit

class ViewController: UIViewController {

    var letterView: UIView!
    var answerLabel: UILabel!
    var guessesLeftLabel: UILabel!
    
    var letterViewConstraints = [NSLayoutConstraint]()
    
    var letterButtons = [UIButton]()
    var answer: String = "" {
        didSet {
            hideAnswerLabel()
        }
    }
    var usedLetters = [Character]()
    var guessesLeft = 0 {
        didSet {
            guessesLeftLabel.text = "Guesses left: \(guessesLeft)"
        }
    }
    var wordList = [String]()
    
    //MARK: - view
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = .white
                
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.textAlignment = .center
        answerLabel.font = UIFont.systemFont(ofSize: 44)
        view.addSubview(answerLabel)
        
        guessesLeftLabel = UILabel()
        guessesLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        guessesLeftLabel.textAlignment = .center
        guessesLeftLabel.font = UIFont.systemFont(ofSize: 22)
        guessesLeftLabel.textColor = UIColor.lightGray
        view.addSubview(guessesLeftLabel)
        
        letterView = UIView()
        letterView.translatesAutoresizingMaskIntoConstraints = false
        //letterView.layer.borderWidth = 1
        //letterView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(letterView)
        
        NSLayoutConstraint.activate([
            
            answerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            answerLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            guessesLeftLabel.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 20),
            guessesLeftLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            guessesLeftLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            letterView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            letterView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.3),
            letterView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            letterView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        createLetterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWords()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateLetterView()
    }
    
    //MARK: - button actions
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let letterStr = sender.titleLabel?.text else { return }
        guard let letter = letterStr.first else { return }

        usedLetters.append(letter)
        sender.isHidden = true

        if !answer.contains(letter) {
            guessesLeft -= 1
            if guessesLeft == 0 {
                finishedGameMessage(won: false)
            }
            return
        }
        
        var labelString = ""
        for letter in answer {
            if usedLetters.contains(letter) {
                labelString.append(String(letter))
            } else {
                labelString.append("?")
            }
        }
        answerLabel.text = labelString
        
        if labelString == answer {
            finishedGameMessage(won: true)
        }
    }
    
    //MARK: - helper functions
    
    func startGame() {
        wordList.shuffle()
        answer = wordList.first!.uppercased()
        guessesLeft = 6
        usedLetters.removeAll()
        for button in letterButtons {
            button.isHidden = false
        }
    }
    
    func calculateNumberOfColumns() -> Int {
        var columns = 0
        if UIDevice.current.model.contains("iPad") {
            columns = 14
        } else {
            columns = UIDevice.current.orientation.isLandscape ? 14 : 7
        }
        return columns
    }
    
    func createLetterView() {
        for letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            let button = UIButton(type: .system)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
            button.setTitle(String(letter), for: .normal)
            button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            //button.layer.borderColor = UIColor.red.cgColor
            //button.layer.borderWidth = 1
            letterView.addSubview(button)
            letterButtons.append(button)
        }
        
        updateLetterView()
    }
    
    func updateLetterView() {
        let columns = calculateNumberOfColumns()
        var col = 0
        
        NSLayoutConstraint.deactivate(letterViewConstraints)
        letterViewConstraints.removeAll()
        
        var nextTopConstraint: NSLayoutAnchor = letterView.topAnchor
        var nextLeadingConstraint: NSLayoutAnchor = letterView.leadingAnchor
        
        for button in letterButtons {
            button.translatesAutoresizingMaskIntoConstraints = false
            letterViewConstraints.append(button.topAnchor.constraint(equalTo: nextTopConstraint))
            letterViewConstraints.append(button.leadingAnchor.constraint(equalTo: nextLeadingConstraint))
            letterViewConstraints.append(button.widthAnchor.constraint(equalTo: letterView.widthAnchor, multiplier: 1 / CGFloat(columns)))
            
            if (col + 1) % columns == 0 {
                col = 0
                nextTopConstraint = button.bottomAnchor
                nextLeadingConstraint = letterView.leadingAnchor
            } else {
                col += 1
                nextLeadingConstraint = button.trailingAnchor
            }
        }
        NSLayoutConstraint.activate(letterViewConstraints)
    }
    
    func hideAnswerLabel() {
        answerLabel.text = ""
        for _ in answer {
            answerLabel.text?.append("?")
        }
    }
    
    func loadWords() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let url = Bundle.main.url(forResource: "hangman", withExtension: "txt") else { return }
            guard let words = try? String(contentsOf: url) else { return }
            self?.wordList = words.components(separatedBy: "\n")
            
            DispatchQueue.main.async {
                self?.startGame()
            }
        }
    }
    
    func finishedGameMessage(won: Bool) {
        let title = won ? "You Win!" : "You Lose!"
        let message = "The answer is [\(answer)]."
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let playAgainAction = UIAlertAction(title: "Play Again?", style: .default) { [weak self] _ in
            self?.startGame()
        }
        ac.addAction(playAgainAction)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(ac, animated: true)
    }
}

