//
//  AddBookViewController.swift
//  ELL App
//
//  Created by RM145-M1 on 11/22/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class AddBookViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var rootRef = FIRDatabase.database().reference()
    
    @IBOutlet weak var loggedInUser: UILabel!
    @IBOutlet weak var subjectPickerView: UIPickerView!
    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var gradePickerView: UIPickerView!
    
    @IBOutlet weak var wordsTextView: UITextView!
    
    var subjects  = ["Language Arts","Social Studies","Math"]
    var grades = ["K","1", "2", "3", "4", "5", "6"]
    
    var subjectRow : Int!
    var gradeRow: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        loggedInUser.text = FIRAuth.auth()!.currentUser?.displayName
        subjectRow = 0;
        gradeRow = 0;
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelAddBook(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.isEqual(subjectPickerView)) {
            return subjects[row]

        }
        else if(pickerView.isEqual(gradePickerView)) {
            return grades[row]
        }
        return "Error"
    }
    
    @IBAction func createBook(sender: AnyObject) {
        let bookName = bookNameTextField.text
        let author = authorTextField.text
        let subjectSelected = subjects[subjectRow]
        let gradeSelected = grades[gradeRow]
        
        if bookName != "" && author != "" {
            let book: [String : String] = ["title" : bookName!, "author" : author!, "subject" : subjectSelected, "grade": gradeSelected]
            rootRef.child("books").childByAutoId().setValuesForKeysWithDictionary(book)
            

        }

    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.isEqual(subjectPickerView)) {
            return subjects.count
            
        }
        else if(pickerView.isEqual(gradePickerView)) {
            return grades.count
        }
        return -1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.isEqual(subjectPickerView)) {
            subjectRow = row
            
        }
        else if(pickerView.isEqual(gradePickerView)) {
            gradeRow = row
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
