//
//  LogInViewController.swift
//  ELL App
//
//  Created by Brian Carreon on 12/1/15.
//  Copyright © 2015 Bcarreon. All rights reserved.
//

import UIKit
import Parse
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var currentUser = PFUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonAction(_ sender: AnyObject) {
        let user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        
        // Get the username and password from the fields and validate through parse
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: {
            (User : PFUser?, Error : Error?) -> Void in
            
            // If valid go to book list view else prompt with log in fail
            if Error == nil {
                DispatchQueue.main.async {
                    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let logInSuccessVC = Storyboard.instantiateViewController(withIdentifier: "bookListView")
                    self.present(logInSuccessVC, animated: true, completion: nil)
                }
            }
            else {
                let _ = SCLAlertView().showError("Log In Failed", subTitle: "The username/password is incorrect")
            }
        })
    }
 
    
    /*@IBAction func logInButtonAction(sender: AnyObject) {
        let email = usernameTextField.text!
        let password = passwordTextField.text!
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            if(error != nil) {
                print("DEVELOPER: Unable to authenticate with Firebase using email")
                print(error)
                SCLAlertView().showError("Log In Failed", subTitle: "The username/password is incorrect")
            }
            else {
                print("DEVELOPER: Successfully authenticated with Firebase using email")
                dispatch_async(dispatch_get_main_queue()) {
                    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let logInSuccessVC = Storyboard.instantiateViewControllerWithIdentifier("bookListView")
                    self.presentViewController(logInSuccessVC, animated: true, completion: nil)
                }
            }
        })
    }*/
    
    
    @IBAction func addBook(_ sender: AnyObject) {
        let email = usernameTextField.text!
        let password = passwordTextField.text!
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if(error != nil) {
                print("DEVELOPER: Unable to authenticate with Firebase using email")
                print(error ?? "No error")
                let _ = SCLAlertView().showError("Log In Failed", subTitle: "The username/password is incorrect")
            }
            else {
                print("DEVELOPER: Successfully authenticated with Firebase using email")
                DispatchQueue.main.async {
                    let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let addBookView = Storyboard.instantiateViewController(withIdentifier: "addBookView")
                    self.present(addBookView, animated: true, completion: nil)
                }
            }
        })

    }

    @IBAction func createNewAccount(_ sender: AnyObject) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createAccView = Storyboard.instantiateViewController(withIdentifier: "createNewAccountView")
        self.present(createAccView, animated: true, completion: nil)
    }

}
