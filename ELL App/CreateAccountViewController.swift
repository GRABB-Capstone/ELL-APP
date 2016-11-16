//
//  CreateAccountViewController.swift
//  ELL App
//
//  Created by RM145-M1 on 11/13/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var typeField: UISegmentedControl!
    
    var rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    /*func completeMySignIn(id: String, userData: Dictionary<String, String>){
        self.rootRef.childByAppendingPath("users").childByAppendingPath(id).setValue(user)
    }*/
    
    

    @IBAction func createAccount(sender: AnyObject) {
        
        
        let firstname = firstnameField.text
        let lastname = lastnameField.text
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        
        if username != "" && email != "" && password != "" && firstname != "" && lastname != "" {
        
        FIRAuth.auth()!.createUserWithEmail(email!, password: password!, completion:{ user, error in
            if error != nil {
                print("DEVELOPER: Unable to authenticate with Firebase using email")
                print(error)
            }
            else {
                print("DEVELOPER: Successfully authenticated with Firebase using email")
                if let user = user {
                    let userData: Dictionary<String, String> = ["firstName": firstname!, "lastName": lastname!, "userName": username!, "email" :email!, "password" : password!]
                    self.rootRef.childByAppendingPath("users").childByAppendingPath(user.uid).setValue(userData)
                    //Not Sure if this is needed yet
                    //NSUserDefaults.standardUserDefaults().setValue(user? ["uid"], forKey: "uid")
                    self.dismissViewControllerAnimated(true, completion: {})
                }
            }
        })
        }
        else {
            //signupErrorAlert("Oops!", message: "Don't forget to enter your name, email, password, and a username.")
            SCLAlertView().showError("Sign Up Failed", subTitle: "Don't forget to enter your name, email, password, and a username.")
        }
    



//        if username != "" && email != "" && password != "" {
//            
//            // Set Email and Password for the New User.
//            
//            DataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
//                
//                if error != nil {
//                    
//                    // There was a problem.
//                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again.")
//                    
//                } else {
//                    
//                    // Create and Login the New User with authUser
//                    DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: {
//                        err, authData in
//                        
//                        let user = ["provider": authData.provider!, "email": email!, "username": username!]
//                        
//                        // Seal the deal in DataService.swift.
//                        DataService.dataService.createNewAccount(authData.uid, user: user)
//                    })
//                    
//                    // Store the uid for future access - handy!
//                    NSUserDefaults.standardUserDefaults().setValue(result ["uid"], forKey: "uid")
//                    
//                    // Enter the app.
//                    self.performSegueWithIdentifier("NewUserLoggedIn", sender: nil)
//                }
//            })
//            
//        } else {
//            signupErrorAlert("Oops!", message: "Don't forget to enter your email, password, and a username.")
//        }
        
    }
//
//
    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
