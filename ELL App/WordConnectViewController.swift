//
//  WordConnectViewController.swift
//  ELL App
//
//  Created by Genton Mo on 1/24/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Parse

class WordConnectViewController: UIViewController {

    @IBOutlet var button1: UIButton?
    @IBOutlet var button2: UIButton?
    @IBOutlet var button3: UIButton?
    @IBOutlet var button4: UIButton?
    @IBOutlet var button5: UIButton?
    @IBOutlet var button6: UIButton?
    @IBOutlet var button7: UIButton?
    @IBOutlet var button8: UIButton?
    var buttons = [UIButton]()
    var objectId = String()
    var query = PFQuery(className: "Book")
    var words = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons.append(button1!)
        buttons.append(button2!)
        buttons.append(button3!)
        buttons.append(button4!)
        buttons.append(button5!)
        buttons.append(button6!)
        buttons.append(button7!)
        buttons.append(button8!)
        
        query.getObjectInBackgroundWithId(objectId) { (object, error) -> Void in
            /*self.words = object!["words"] as! [String]
            print(self.words)*/
            var arr = object!["words"] as! [String]
            var i = 0
            for word in arr {
                self.buttons[i++].setTitle(word, forState: UIControlState.Normal)

            }
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
