//
//  SentenceFrameViewController.swift
//  ELL App
//
//  Created by Genton Mo on 2/24/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Parse

// This activity SHOULD replace Word Connect. See Word Connect for more details.

class SentenceFrameViewController: UIViewController {
    
    var newButton: UIButton?
    var explanation = UITextField()
    var sentence = UILabel()
    var objectId = String()
    var query = PFQuery(className: "Book")
    var selectedButtons = [UIButton]()
    var firstWord = "________"
    var secondWord = "________"
    
    var word1 = [String]()
    var word2 = [String]()
    var notes = [String]()
    var sentences = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = SCLAlertView().showInfo("Sentence Frame", subTitle: "Select two words and explain how they are similar.")
        
        var i = 0
        let centerX = Int(self.view.center.x)
        
        // Looks for the words in the Book
        query.getObjectInBackground(withId: objectId) { (object, error) -> Void in
            
            let arr = object!["words"] as! [String]
            let getRandom = self.randomSequenceGenerator(0, max: arr.count - 1)
            var sentenceY: Int
            
            if arr.count > 0 {
                for _ in 0...arr.count - 1 {
                    if i < 8 {
                    
                        self.makeButton(arr[getRandom()], buttonNum: i)
                        i += 1
                    }
                }
                
                sentenceY = 300 + (i + 1) / 2 * 70
                
                self.sentence.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 30, height: 30)
                self.sentence.center = CGPoint(x: centerX, y: sentenceY)
                self.sentence.text = "\(self.firstWord) is similar to \(self.secondWord) because"
                self.sentence.textAlignment = NSTextAlignment.center
                self.sentence.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightRegular)
                self.view.addSubview(self.sentence)
                
                self.explanation.frame = CGRect(x: 0, y: 0, width: 400, height: 30)
                self.explanation.center = CGPoint(x: centerX, y: sentenceY + 40)
                self.explanation.placeholder = "Reason"
                self.explanation.borderStyle = UITextBorderStyle.roundedRect
                self.view.addSubview(self.explanation)
                
                self.newButton = UIButton(type: UIButtonType.system)
                self.newButton!.setTitleColor(UIColor.white, for: UIControlState())
                self.newButton!.addTarget(self, action: #selector(SentenceFrameViewController.submit(_:)), for: UIControlEvents.touchUpInside)
                self.newButton!.frame = CGRect(x: 0, y: 0, width: 84, height: 33)
                self.newButton!.center = CGPoint(x: centerX, y: sentenceY + 90)
                self.newButton!.setTitle("SUBMIT", for: UIControlState())
                self.newButton!.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightHeavy)
                self.newButton!.backgroundColor = UIColor(red: 0.439, green: 0.608, blue: 0.867, alpha: 1)
                self.view.addSubview(self.newButton!)
            }
            
            else {
                let noWords = UILabel()
                
                noWords.frame = CGRect(x: 0, y: 0, width: 400, height: 30)
                noWords.center = CGPoint(x: centerX, y: 373)
                noWords.textAlignment = NSTextAlignment.center
                noWords.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightRegular)
                noWords.text = "There are no words"
                self.view.addSubview(noWords)

            }
        }
    }
    
    func makeButton(_ word: String, buttonNum: Int) {
        let centerX = Int(self.view.center.x)
        
        self.newButton = UIButton()
        self.newButton!.addTarget(self, action: #selector(SentenceFrameViewController.pressed(_:)), for: UIControlEvents.touchUpInside)
        self.newButton!.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        self.newButton!.center = CGPoint(x: centerX + 110 * ((buttonNum % 2 == 0) ? -1 : 1), y: 300 + buttonNum / 2 * 70)
        self.newButton!.setTitle(word, for: UIControlState())
        self.newButton!.titleLabel!.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        self.newButton!.isSelected = false
        self.newButton!.backgroundColor = UIColor.clear
        self.view.addSubview(self.newButton!)
    }
    
    // Checks how many buttons are currently pressed. Ensures no more than 2 are pressed at once.
    func pressed(_ sender: UIButton) {
        
        if sender.backgroundColor == UIColor.clear {
            
            if selectedButtons.count < 2 {
                sender.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
                selectedButtons.insert(sender, at: 0)
                if firstWord == "________" {
                    firstWord = sender.currentTitle!
                }
                
                else {
                    secondWord = sender.currentTitle!
                }
            }
        }
            
        else {
            removeButtonFromArray(sender)
            if firstWord == sender.currentTitle! {
                firstWord = "________"
            }
            
            else if secondWord == sender.currentTitle! {
                secondWord = "________"
            }
            sender.backgroundColor = UIColor.clear
        }
        
        sentence.text = "\(self.firstWord) is similar to \(self.secondWord) because "
        /*var firstRange = sentence.text?.rangeOfString(firstWord)
        var secondRange = sentence.text?.rangeOfString(secondWord)
        var attributedString = NSMutableAttributedString(string: (sentence.text)!)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: firstRange)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: secondRange)*/
    }
    
    func submit(_ sender: UIButton) {
        
        if selectedButtons.count == 2 && explanation.text != "" {
            word1.append(selectedButtons[0].currentTitle!)
            word2.append(selectedButtons[1].currentTitle!)
            notes.append(explanation.text!)
            sentences.append(sentence.text! + explanation.text!)
            for button in selectedButtons {
                button.backgroundColor = UIColor.clear
            }
            
            firstWord = "________"
            secondWord = "________"
            explanation.text = ""
            
            sentence.text = "\(self.firstWord) is similar to \(self.secondWord) because "
            
            selectedButtons.removeAll()

            JLToast.makeText("Submitted", duration: JLToastDelay.ShortDelay).show()
        }
    }
    
    func removeButtonFromArray(_ toRemove: UIButton) {
        
        if selectedButtons[0].currentTitle == toRemove.currentTitle {
            
            if selectedButtons.count == 1 {
                selectedButtons.removeAll()
            }
                
            else {
                selectedButtons[0] = selectedButtons[1]
                selectedButtons.removeLast()
            }
        }
            
        else {
            selectedButtons.removeLast()
        }
    }
    
    func randomSequenceGenerator(_ min: Int, max: Int) -> () -> Int {
        var numbers: [Int] = []
        return {
            if numbers.count == 0 {
                numbers = Array(min ... max)
            }
            
            let index = Int(arc4random_uniform(UInt32(numbers.count)))
            return numbers.remove(at: index)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*@IBAction func nextButtonAction(sender: AnyObject) {
        performSegueWithIdentifier("viewsentence", sender: self)
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewsentences" {
            let vc = segue.destination as! SentenceFrameTableViewController
            vc.sentences = sentences
        }
    }
}
