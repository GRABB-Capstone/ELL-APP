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
    @IBOutlet var userType: UISegmentedControl!
    
    var rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelCreateAccount(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }
    

    @IBAction func createAccount(_ sender: AnyObject) {
        
        
        let firstname = firstnameField.text
        let lastname = lastnameField.text
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        
        if username != "" && email != "" && password != "" && firstname != "" && lastname != "" {
        
        FIRAuth.auth()!.createUser(withEmail: email!, password: password!, completion:{ user, error in
            if error != nil {
                print("DEVELOPER: Unable to authenticate with Firebase using email")
                print(error ?? "No Error")
            }
            else {
                print("DEVELOPER: Successfully authenticated with Firebase using email")
                if let user = user {
                    let userData: Dictionary<String, String> = ["firstName": firstname!, "lastName": lastname!, "userName": username!, "email" :email!, "password" : password!]
                    if(self.userType.selectedSegmentIndex == 0) {
                        self.rootRef.child("users").child("teachers").child(user.uid).setValue(userData)
                    }
                    else if(self.userType.selectedSegmentIndex == 1) {
                        self.rootRef.child("users").child("students").child(user.uid).setValue(userData)
                    }
                    //Not Sure if this is needed yet
                    //NSUserDefaults.standardUserDefaults().setValue(user? ["uid"], forKey: "uid")
                    self.dismiss(animated: true, completion: {})
                }
            }
        })
        }
        else {

            let _ = SCLAlertView().showError("Sign Up Failed", subTitle: "Don't forget to enter your name, email, password, and a username.")
        }
        
    }

    func signupErrorAlert(_ title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
