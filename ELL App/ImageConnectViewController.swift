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
    var img1 = [String]()
    var img2 = [String]()
    var notes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 0
        //let centerX = Int(self.view.center.x)
        
        radioButtonController.delegate = self
        radioButtonController.shouldLetDeSelect = true
        
        bookQuery.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in
            
            self.bookTitle = object!["title"] as! String
        }
    
        imgQuery.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            
            /*for img in object! {
                if (img["book"] as! String) == "Harry Potter" {
                    let image = img["image"] as! PFFile
                    
                    image.getDataInBackgroundWithBlock { (imageData: NSData, error: NSError!) -> Void in
                        self.newImg = UIImage(data: imageData)
                    self.makeButton(self.newImg!, buttonNum: i++)
                    print(img["book"])
                    }
                }
            }*/
            /*
            let arr = object!["book"] as! String
            
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
            
            self.newButton = UIButton()
            self.newButton!.addTarget(self, action: "submit:", forControlEvents: UIControlEvents.TouchUpInside)
            self.newButton!.frame = CGRect(x: 0, y: 0, width: 84, height: 33)
            self.newButton!.center = CGPoint(x: centerX, y: 373 + (i + 3) / 2 * 85)
            self.newButton!.setTitle("SUBMIT", forState: UIControlState.Normal)
            self.newButton!.titleLabel!.font = UIFont.systemFontOfSize(15, weight: UIFontWeightHeavy)
            self.newButton!.backgroundColor = UIColor(red: 0.439, green: 0.608, blue: 0.867, alpha: 1)
            self.view.addSubview(self.newButton!)
            */
        }
    }
    
    func makeButton(image: UIImage, buttonNum: Int) {
        let centerX = Int(self.view.center.x)
        
        self.newButton = UIButton()
        self.newButton!.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.newButton!.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        self.newButton!.center = CGPoint(x: centerX + 110 * ((buttonNum % 2 == 0) ? -1 : 1), y: 373 + buttonNum / 2 * 85)
        //self.newButton!.setTitle(image, forState: UIControlState.Normal)
        //self.newButton!.titleLabel!.font = UIFont.systemFontOfSize(16, weight: UIFontWeightBold)
        self.newButton!.setBackgroundImage(image, forState: UIControlState.Normal)
        self.newButton!.selected = false
        self.newButton!.backgroundColor = UIColor.clearColor()
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
            img1.append(selectedButtons[0].currentTitle!)
            img2.append(selectedButtons[1].currentTitle!)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   /*
    @IBAction func nextButtonAction(sender: AnyObject) {
        performSegueWithIdentifier("viewpairs", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewpairs" {
            let vc = segue.destinationViewController as! WordConnectTableViewController
            vc.img1 = img1
            vc.img2 = img2
            vc.notes = notes
        }
        
    }*/


}
