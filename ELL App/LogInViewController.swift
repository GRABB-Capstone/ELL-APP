//
//  LogInViewController.swift
//  ELL App
//
//  Created by Brian Carreon on 12/1/15.
//  Copyright © 2015 Bcarreon. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var verificationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonAction(sender: AnyObject) {
        var user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        self.verificationLabel.text = ""
        
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!, block: {
            (User : PFUser?, Error : NSError?) -> Void in
            
            if Error == nil {
                dispatch_async(dispatch_get_main_queue()) {
                    var Storyboard = UIStoryboard(name: "Main", bundle: nil)
                    var logInSuccessVC = Storyboard.instantiateViewControllerWithIdentifier("bookListVC")
                    self.presentViewController(logInSuccessVC, animated: true, completion: nil)
                }
            }
            else {
                self.verificationLabel.text = "Username/Password combination not valid"
            }
        })
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
