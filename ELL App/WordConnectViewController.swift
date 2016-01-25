//
//  WordConnectViewController.swift
//  ELL App
//
//  Created by Genton Mo on 1/24/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Parse

class WordConnectViewController: UIViewController, SSRadioButtonControllerDelegate {

    var newButton: UIButton?
    let commentBox = UITextField()
    var objectId = String()
    var query = PFQuery(className: "Book")
    let radioButtonController = SSRadioButtonsController()
    var selectedButtons = [UIButton]()
    var butt: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 0
        let centerX = Int(self.view.center.x)
        
        radioButtonController.delegate = self
        radioButtonController.shouldLetDeSelect = true

        query.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in

            let arr = object!["words"] as! [String]
            
            for word in arr {
                if i < 8 {
                    self.makeButton(word, buttonNum: i++)
                }
            }
            
            self.commentBox.frame = CGRect(x: 0, y: 0, width: 400, height: 30)
            self.commentBox.center = CGPoint(x: centerX, y: 373 + (i + 1) / 2 * 85)
            self.commentBox.placeholder = "Optional Notes"
            self.commentBox.borderStyle = UITextBorderStyle.RoundedRect
            self.view.addSubview(self.commentBox)
            
            
            print(i)
        }
        
        print(5)
        self.butt = UIButton()
        self.butt!.center = CGPoint(x: centerX, y: 373 + (i + 3) / 2 * 85)
        self.butt!.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        self.butt!.setTitle("Submit", forState: UIControlState.Normal)
        //self.butt!.sizeToFit()
        self.butt!.backgroundColor = UIColor.blueColor()
        self.view.addSubview(self.butt!)
    }
    
    func makeButton(word: String, buttonNum: Int) {
        let centerX = Int(self.view.center.x)
        
        self.newButton = UIButton()
        self.newButton!.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.newButton!.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        self.newButton!.center = CGPoint(x: centerX + 150 * ((buttonNum % 2 == 0) ? -1 : 1), y: 373 + buttonNum / 2 * 85)
        self.newButton!.setTitle(word, forState: UIControlState.Normal)
        self.newButton!.selected = false
        self.newButton!.backgroundColor = UIColor.clearColor()
        self.radioButtonController.addButton(self.newButton!)
        self.view.addSubview(self.newButton!)
    }
    
    func pressed(sender: UIButton) {
        
        if sender.backgroundColor == UIColor.clearColor() {
            
            if selectedButtons.count < 2 {
                sender.backgroundColor = UIColor.blueColor()
                selectedButtons.insert(sender, atIndex: 0)
            }
        }
            
        else {
            removeButtonFromArray(sender)
            sender.backgroundColor = UIColor.clearColor()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
