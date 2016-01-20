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
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        label.text = bookTitle
        query.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in
            self.words = object!["words"] as! [String]
            print(self.words)
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
