//
//  ViewController.swift
//  Silly Song
//
//  Created by Mauricio A Cabreira on 15/05/17.
//  Copyright © 2017 Mauricio A Cabreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        lyricsView.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func shortNameFromName(_ name: String) -> String {
        
        let vowelSet = NSCharacterSet(charactersIn: "aeiou")
        let firstVowelRange = name.lowercased().rangeOfCharacter(from: vowelSet as CharacterSet)

        
        if firstVowelRange?.lowerBound != nil {
            return name.lowercased().substring(from: firstVowelRange!.lowerBound)
        }
        
        //if name does not contain vowels, return the original name
        return name
    }
    
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        let shortName = shortNameFromName(fullName)
        
        let lyrics = lyricsTemplate
            .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
            .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
    }
    
    //Our implementation calls the text field’s resignFirstResponder method, which will both hide the keyboard and trigger the text field’s “Editing Did End” event, which will in turn generate and display the lyrics, thanks to the action we created earlier. We also return false to prevent any other response to the return key.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

   
    @IBAction func reset(_ sender: Any) {
        //clear the name field and lyrics text box
        nameField.text = ""
        lyricsView.text = ""
        nameField.returnKeyType = UIReturnKeyType.done
        
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        lyricsView.text =  lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
        
    }

}

