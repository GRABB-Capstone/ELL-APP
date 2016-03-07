//
//  ActivitiesViewController.swift
//  ELL App
//
//  Created by Brian Carreon on 1/19/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Parse

class ActivitiesViewController: UIViewController {
    
    var bookTitle = String()
    var objectId = String()
    var words = [String]()
    var query = PFQuery(className: "Book")
    var selectedObjectId = String()
    var nextObjectId = String()

    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        label.text = bookTitle
        // Tests if Book got segued from BookTable to ActivitiesVC. Prints all words the book.
        query.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in
            self.words = object!["words"] as! [String]
            print(self.words)
        }
        
    }
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue()) {
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let logInSuccessVC = Storyboard.instantiateViewControllerWithIdentifier("logInView")
            self.presentViewController(logInSuccessVC, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "wordconnect" {
            let vc = segue.destinationViewController as! WordConnectViewController
            vc.objectId = self.objectId
        }
        
        else if segue.identifier == "assessment" {
            let vc = segue.destinationViewController as! AssessmentViewController
            vc.words = words
        }
        
        else if segue.identifier == "imageconnect" {
            let vc = segue.destinationViewController as! ImageConnectViewController
            vc.objectId = objectId
        }
        
        else if segue.identifier == "sentenceframe" {
            let vc = segue.destinationViewController as! SentenceFrameViewController
            vc.objectId = objectId
        }
        
        else if segue.identifier == "doodle" {
            let vc = segue.destinationViewController as! DoodleViewController
            vc.words = words
        }
    }
    
    
    
    
    
}
