//
//  ViewController.swift
//  Project5
//
//  Created by Eduardo Maestri Righes on 19/05/2021.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        
        if let usedWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: usedWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            // This shouldn't happen, just an indicator something is wrong
            allWords = [ "silkworm" ]
        }
        
        startGame()
    }

    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func showErrorMessage(title errorTitle: String, message errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let startWord = title!
        let lowerAnswer = answer.lowercased()
        
        if lowerAnswer == startWord {
            showErrorMessage(title: "Word is start word", message: "You can't use the start word!")
        } else {
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        //
                        // About the debug challenge...
                        // Insert lowercase or do isOriginal to be case-insensitive
                        //
                        usedWords.insert(lowerAnswer, at: 0)
                        // we have our usedWords[0] in place so once we
                        // add the table row, it will fetch that
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        
                        return
                    } else {
                        showErrorMessage(title: "Word not recognised", message: "You can't make them up, you know!")
                    }
                } else {
                    showErrorMessage(title: "Word already used", message: "Be more original!")
                }
            } else {
                guard let title = title?.lowercased() else { return }
                showErrorMessage(title: "Word not possible", message: "You can't spell that word from \(title)")
            }
        }
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        //
        // If you want to make the check case insensitive...
        //
        
        //return !usedWords.contains { $0.lowercased() == word }
        
        //return !usedWords.contains { item in
        //    item.lowercased() == word
        //}
        
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        if word.count < 3 {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

