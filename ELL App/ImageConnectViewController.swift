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
    var bookTitle = String()
    var selectedButtons = [UIButton]()
    var newImg: UIImage?
    var images = [PFFile]()
    var img1 = [UIImage]()
    var img2 = [UIImage]()
    var notes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Currently only pairs images with images. Future iterations of this activity should pair images with words.
        let _ = SCLAlertView().showInfo("Image Connect", subTitle: "Choose two images and describe their relationship.")
        
        var i = 0
        let centerX = Int(self.view.center.x)
        
        // Looks for book's images inside the database
        bookQuery.getObjectInBackground(withId: objectId) { (object, error) -> Void in
            
            self.bookTitle = object!["title"] as! String
    
            self.imgQuery.findObjectsInBackground { (object, error) -> Void in
                var imgCount = 0
                for img in object! {
                    if (img["book"] as! String) == self.bookTitle {
                        self.images.append(img["image"] as! PFFile)
                        imgCount += 1
                    }
                }
                // Randomly displays up to 6 images stored in the database. All locations are updated dynamically
                if imgCount > 0 {
                    let getRandom = self.randomSequenceGenerator(0, max: self.images.count - 1)
                    if self.images.count > 0 {
                        for _ in 0...self.images.count - 1 {
                            self.images[getRandom()].getDataInBackground { (pic, error) -> Void in
                                if let dlImage = UIImage(data: pic!) {
                                    if i < 6 {                        
                                        self.makeButton(dlImage, buttonNum: i)
                                        i += 1
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
                    self.commentBox.center = CGPoint(x: centerX, y: 150 + (numImg + 1) / 2 * 150)
                    self.commentBox.placeholder = "Optional Notes"
                    self.commentBox.borderStyle = UITextBorderStyle.roundedRect
                    self.view.addSubview(self.commentBox)
                    
                    self.newButton = UIButton()
                    self.newButton!.addTarget(self, action: #selector(ImageConnectViewController.submit(_:)), for: UIControlEvents.touchUpInside)
                    self.newButton!.frame = CGRect(x: 0, y: 0, width: 84, height: 33)
                    self.newButton!.center = CGPoint(x: centerX, y: 70 + (numImg + 3) / 2 * 150)
                    self.newButton!.setTitle("SUBMIT", for: UIControlState())
                    self.newButton!.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightHeavy)
                    self.newButton!.backgroundColor = UIColor(red: 0.439, green: 0.608, blue: 0.867, alpha: 1)
                    self.view.addSubview(self.newButton!)
                }
                
                else {
                    let noImages = UILabel()
                    
                    noImages.frame = CGRect(x: 0, y: 0, width: 400, height: 30)
                    noImages.center = CGPoint(x: centerX, y: 373)
                    noImages.textAlignment = NSTextAlignment.center
                    noImages.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightRegular)
                    noImages.text = "There are no images"
                    self.view.addSubview(noImages)

                }
            }
        }
    }
    // Creates a button that is displayed as an image
    func makeButton(_ image: UIImage, buttonNum: Int) {
        let centerX = Int(self.view.center.x)
        
        self.newButton = UIButton()
        self.newButton!.addTarget(self, action: #selector(ImageConnectViewController.pressed(_:)), for: UIControlEvents.touchUpInside)
        self.newButton!.frame = CGRect(x: 0, y: 0, width: 145, height: 145)
        self.newButton!.center = CGPoint(x: centerX + 110 * ((buttonNum % 2 == 0) ? -1 : 1), y: 200 + buttonNum / 2 * 150)
        self.newButton!.setImage(image, for: UIControlState())
        self.newButton!.isSelected = false
        self.newButton!.backgroundColor = UIColor.clear
        self.newButton!.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.view.addSubview(self.newButton!)
    }
    
    // Checks how many buttons are currently pressed. Ensures no more than 2 are pressed at once.
    func pressed(_ sender: UIButton) {
        
        if sender.backgroundColor == UIColor.clear {
            
            if selectedButtons.count < 2 {
                sender.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
                selectedButtons.insert(sender, at: 0)
            }
        }
            
        else {
            removeButtonFromArray(sender)
            sender.backgroundColor = UIColor.clear
        }
    }
    
    func submit(_ sender: UIButton) {
        
        if selectedButtons.count == 2 {
            img1.append(selectedButtons[0].currentImage!)
            img2.append(selectedButtons[1].currentImage!)
            notes.append(commentBox.text!)
            
            for button in selectedButtons {
                button.backgroundColor = UIColor.clear
            }
            
            commentBox.text = ""
            
            selectedButtons.removeAll()
            
            JLToast.makeText("Submitted", duration: JLToastDelay.ShortDelay).show()
        }
    }
    
    func removeButtonFromArray(_ toRemove: UIButton) {
        print(toRemove.currentImage ?? "No Image")
        if selectedButtons[0].currentImage == toRemove.currentImage {
            
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
   
    @IBAction func nextButtonAction(_ sender: AnyObject) {
        performSegue(withIdentifier: "viewImagePairs", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewImagePairs" {
            let vc = segue.destination as! ImageConnectTableViewController
            vc.img1 = img1
            vc.img2 = img2
            vc.notes = notes
        }
        
    }
}
