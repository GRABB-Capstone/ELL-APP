//
//  WordConnectViewController.swift
//  ELL App
//
//  Created by Genton Mo on 1/24/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Parse

// This activity SHOULD be phased out and replaced with Sentence Frame. You will need to
// think of a replacement activity. Ask Briana's students for activities they would like
// to see.

class WordConnectViewController: UIViewController, SSRadioButtonControllerDelegate {

    var newButton: UIButton?
    let commentBox = UITextField()
    var objectId = String()
    var query = PFQuery(className: "Book")
    var selectedButtons = [UIButton]()
    var word1 = [String]()
    var word2 = [String]()
    var notes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SCLAlertView().showInfo("Word Connect", subTitle: "Choose two words and describe their relationship.")
        
        var i = 0
        let centerX = Int(self.view.center.x)
        
        query.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in

            let arr = object!["words"] as! [String]
            let getRandom = self.randomSequenceGenerator(0, max: arr.count - 1)
            
            if arr.count > 0 {
                for _ in 0...arr.count - 1 {
                    if i < 8 {
                        self.makeButton(arr[getRandom()], buttonNum: i++)
                    }
                }

                self.commentBox.frame = CGRect(x: 0, y: 0, width: 400, height: 30)
                self.commentBox.center = CGPoint(x: centerX, y: 320 + (i + 1) / 2 * 70)
                self.commentBox.placeholder = "Optional Notes"
                self.commentBox.borderStyle = UITextBorderStyle.RoundedRect
                self.view.addSubview(self.commentBox)
                
                self.newButton = UIButton(type: UIButtonType.System)
                self.newButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                self.newButton!.addTarget(self, action: "submit:", forControlEvents: UIControlEvents.TouchUpInside)
                self.newButton!.frame = CGRect(x: 0, y: 0, width: 84, height: 33)
                self.newButton!.center = CGPoint(x: centerX, y: 320 + (i + 3) / 2 * 70)
                self.newButton!.setTitle("SUBMIT", forState: UIControlState.Normal)
                self.newButton!.titleLabel!.font = UIFont.systemFontOfSize(15, weight: UIFontWeightHeavy)
                self.newButton!.backgroundColor = UIColor(red: 0.439, green: 0.608, blue: 0.867, alpha: 1)
                self.view.addSubview(self.newButton!)
            }
            
            else {
                let noWords = UILabel()
                
                noWords.frame = CGRect(x: 0, y: 0, width: 400, height: 30)
                noWords.center = CGPoint(x: centerX, y: 373)
                noWords.textAlignment = NSTextAlignment.Center
                noWords.font = UIFont.systemFontOfSize(22, weight: UIFontWeightRegular)
                noWords.text = "There are no words"
                self.view.addSubview(noWords)
            }
        }
    }
    
    func makeButton(word: String, buttonNum: Int) {
        let centerX = Int(self.view.center.x)
        
        self.newButton = UIButton()
        self.newButton!.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.newButton!.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        self.newButton!.center = CGPoint(x: centerX + 110 * ((buttonNum % 2 == 0) ? -1 : 1), y: 320 + buttonNum / 2 * 70)
        self.newButton!.setTitle(word, forState: UIControlState.Normal)
        self.newButton!.titleLabel!.font = UIFont.systemFontOfSize(16, weight: UIFontWeightBold)
        self.newButton!.selected = false
        self.newButton!.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.newButton!)
    }
    
    func pressed(sender: UIButton) {
        
        if sender.backgroundColor == UIColor.clearColor() {
            
            if selectedButtons.count < 2 {
                sender.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
                selectedButtons.insert(sender, atIndex: 0)
            }
        }
            
        else {
            removeButtonFromArray(sender)
            sender.backgroundColor = UIColor.clearColor()
        }
    }
    
    func submit(sender: UIButton) {
        
        if selectedButtons.count == 2 {
            word1.append(selectedButtons[0].currentTitle!)
            word2.append(selectedButtons[1].currentTitle!)
            notes.append(commentBox.text!)
            
            for button in selectedButtons {
                button.backgroundColor = UIColor.clearColor()
            }
            
            commentBox.text = ""
            
            selectedButtons.removeAll()
            
            JLToast.makeText("Submitted", duration: JLToastDelay.ShortDelay).show()
        }
    }
    
    func removeButtonFromArray(toRemove: UIButton) {

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

    func randomSequenceGenerator(min: Int, max: Int) -> () -> Int {
        var numbers: [Int] = []
        return {
            if numbers.count == 0 {
                numbers = Array(min ... max)
            }
            
            let index = Int(arc4random_uniform(UInt32(numbers.count)))
            return numbers.removeAtIndex(index)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonAction(sender: AnyObject) {
        performSegueWithIdentifier("viewpairs", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewpairs" {
            let vc = segue.destinationViewController as! WordConnectTableViewController
            vc.word1 = word1
            vc.word2 = word2
            vc.notes = notes
        }
        
    }
    

}
