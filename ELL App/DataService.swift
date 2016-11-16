//
//  DataService.swift
//  ELL App
//
//  Created by Nikhil Ahuja on 11/13/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DataService {
    
    var rootRef = FIRDatabase.database().reference()
    static let dataService = DataService()
    
    
//    private var _BASE_REF = rootRef(url: "\(BASE_URL)")
//    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
//    private var _JOKE_REF = Firebase(url: "\(BASE_URL)/jokes")
//
//    var BASE_REF: Firebase {
//        return _BASE_REF
//    }
//    
//    var USER_REF: Firebase {
//        return _USER_REF
//    }
//    
//    var CURRENT_USER_REF: Firebase {
//        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
//        
//        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
//        
//        return currentUser!
//    }
//    
//    var JOKE_REF: Firebase {
//        return _JOKE_REF
//    }
//    
//    func createNewAccount(uid: String, user: Dictionary<String, String>) {
//        
//        // A User is born.
//        
//        self.rootRef.child(<#T##pathString: String##String#>)
//    }
//
//    func createNewJoke(joke: Dictionary<String, AnyObject>) {
//        
//        // Save the Joke
//        // JOKE_REF is the parent of the new Joke: "jokes".
//        // childByAutoId() saves the joke and gives it its own ID.
//        
//        let firebaseNewJoke = JOKE_REF.childByAutoId()
//        
//        // setValue() saves to Firebase.
//        
//        firebaseNewJoke.setValue(joke)
//    }
}