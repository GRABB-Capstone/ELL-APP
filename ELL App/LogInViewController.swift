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
    
    var currentUser = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonAction(sender: AnyObject) {
        let user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!, block: {
            (User : PFUser?, Error : NSError?) -> Void in
            
            if Error == nil {
                dispatch_async(dispatch_get_main_queue()) {
                    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let logInSuccessVC = Storyboard.instantiateViewControllerWithIdentifier("bookListView")
                    self.presentViewController(logInSuccessVC, animated: true, completion: nil)
                }
            }
            else {
                SCLAlertView().showError("Log In Failed", subTitle: "The username/password is incorrect")
            }
        })
    }

}
