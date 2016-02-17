//
//  ImageConnectViewController.swift
//  ELL App
//
//  Created by Genton Mo on 1/25/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Parse

class ImageConnectViewController: UIViewController, SSRadioButtonControllerDelegate {

    var newButton: UIButton?
    let commentBox = UITextField()
    var objectId = String()
    var bookQuery = PFQuery(className: "Book")
    var imgQuery = PFQuery(className: "Image")
    let radioButtonController = SSRadioButtonsController()
    var bookTitle = String()
    var selectedButtons = [UIButton]()
    var newImg: UIImage?
    var images = [PFFile]()
    var img1 = [UIImage]()
    var img2 = [UIImage]()
    var notes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 0
        let centerX = Int(self.view.center.x)
        
        radioButtonController.delegate = self
        radioButtonController.shouldLetDeSelect = true
        
        bookQuery.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in
            
            self.bookTitle = object!["title"] as! String
        
    
            self.imgQuery.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                var imgCount = 0
                for img in object! {
                    if (img["book"] as! String) == self.bookTitle {
                        self.images.append(img["image"] as! PFFile)
                        imgCount++

                    }
                }
                
                let getRandom = self.randomSequenceGenerator(0, max: self.images.count - 1)
                if self.images.count > 0 {
                    for _ in 0...self.images.count - 1 {
                        self.images[getRandom()].getDataInBackgroundWithBlock { (pic, error) -> Void in
                            if let dlImage = UIImage(data: pic!) {
                                if i < 6 {
                                    self.makeButton(dlImage, buttonNum: i++)
                                }
                            }
                        }
                    }
                }
                
                var numImg = self.images.count
                
                if numImg > 6 {
                    numImg = 6
                }
                
                self.commentBox.frame = CGRect(x: 0, y: 0, width: 400, height: 30)
                self.commentBox.center = CGPoint(x: centerX, y: 200 + (numImg + 1) / 2 * 175)
                self.commentBox.placeholder = "Optional Notes"
                self.commentBox.borderStyle = UITextBorderStyle.RoundedRect
                self.view.addSubview(self.commentBox)
                
                self.newButton = UIButton()
                self.newButton!.addTarget(self, action: "submit:", forControlEvents: UIControlEvents.TouchUpInside)
                self.newButton!.frame = CGRect(x: 0, y: 0, width: 84, height: 33)
                self.newButton!.center = CGPoint(x: centerX, y: 75 + (numImg + 3) / 2 * 175)
                self.newButton!.setTitle("SUBMIT", forState: UIControlState.Normal)
                self.newButton!.titleLabel!.font = UIFont.systemFontOfSize(15, weight: UIFontWeightHeavy)
                self.newButton!.backgroundColor = UIColor(red: 0.439, green: 0.608, blue: 0.867, alpha: 1)
                self.view.addSubview(self.newButton!)
            }
        }
    }
    
    func makeButton(image: UIImage, buttonNum: Int) {
        let centerX = Int(self.view.center.x)
        
        self.newButton = UIButton()
        self.newButton!.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.newButton!.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        self.newButton!.center = CGPoint(x: centerX + 110 * ((buttonNum % 2 == 0) ? -1 : 1), y: 250 + buttonNum / 2 * 175)
        //self.newButton!.setBackgroundImage(image, forState: UIControlState.Normal)
        self.newButton!.setImage(image, forState: .Normal)
        self.newButton!.selected = false
        self.newButton!.backgroundColor = UIColor.clearColor()
        self.newButton!.backgroundRectForBounds(CGRect(x: 0, y: 0, width: 300, height: 300))
        self.radioButtonController.addButton(self.newButton!)
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
            img1.append(selectedButtons[0].currentImage!)
            img2.append(selectedButtons[1].currentImage!)
            notes.append(commentBox.text!)
            
            for button in selectedButtons {
                button.backgroundColor = UIColor.clearColor()
            }
            
            commentBox.text = ""
            
            selectedButtons.removeAll()
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
        performSegueWithIdentifier("viewImagePairs", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewImagePairs" {
            let vc = segue.destinationViewController as! ImageConnectTableViewController
            vc.img1 = img1
            vc.img2 = img2
            vc.notes = notes
        }
        
    }
}
