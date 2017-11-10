//
//  ViewController.swift
//  Apple pie
//
//  Created by Eloy Testerink on 09/11/2017.
//  Copyright © 2017 Eloy Testerink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["hond", "kat", "vis",
    "walvis", "irisschlundtbodien", "eloytesterink"]
    
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!


    
    //Tree picture
    @IBOutlet weak var treeImageView: UIImageView!
    
    //correct word label
    @IBOutlet weak var correctLabelWord: UILabel!
    
    //scorelabel
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Collective outlet for buttons
    @IBOutlet var letterButtons: [UIButton]!
    
    //button linked to press function
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        else {
            updateUI()
        }
    }
    
    //This initializes a new game
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    //Retrieves first word from the list of words and puts game values(word and incorrect moves) is currentGame.
    func newRound() {
        if !listOfWords.isEmpty {
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
        enableLetterButtons(true)
        updateUI()
        }
        else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    // update the label in the game
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctLabelWord.text = wordWithSpacing
        scoreLabel.text = " Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

