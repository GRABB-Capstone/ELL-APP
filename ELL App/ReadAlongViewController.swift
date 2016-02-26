//
//  ReadAlongViewController.swift
//  ELL App
//
//  Created by Brian Carreon on 1/22/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
//import SCLAlertView

class ReadAlongViewController: UIViewController {

    @IBOutlet var word: UITextField!
    @IBOutlet var page: UITextField!
    @IBOutlet var notes: UITextField!
    
    var wordCollection = [String]()
    var pageCollection = [String]()
    var notesCollection = [String]()
    
    @IBAction func submitButtonAction(sender: AnyObject) {
        self.wordCollection.append(word.text!)
        self.pageCollection.append(page.text!)
        self.notesCollection.append(notes.text!)
        
        word.text = ""
        page.text = ""
        notes.text = ""
    }
    
    @IBAction func nextButtonAction(sender: AnyObject) {
        performSegueWithIdentifier("readAlongContinued", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "readAlongContinued") {
            var vc = segue.destinationViewController as! ReadAlongTableViewController
            vc.words = self.wordCollection
            vc.pages = self.pageCollection
            vc.notes = self.notesCollection
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        SCLAlertView().showInfo("Read Along", subTitle: "Have student read the book and input any words to review with their page number.")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
