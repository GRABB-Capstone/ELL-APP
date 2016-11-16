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
        
        // Get the username and password from the fields and validate through parse
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!, block: {
            (User : PFUser?, Error : NSError?) -> Void in
            
            // If valid go to book list view else prompt with log in fail
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
    

    @IBAction func createNewAccount(sender: AnyObject) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createAccView = Storyboard.instantiateViewControllerWithIdentifier("createNewAccountView")
        self.presentViewController(createAccView, animated: true, completion: nil)
    }

}
