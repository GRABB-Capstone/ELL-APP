//
//  AddBookViewController.swift
//  ELL App
//
//  Created by RM145-M1 on 11/22/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Firebase

class AddBookViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    var rootRef = FIRDatabase.database().reference()
    var storageRef = FIRStorage.storage().reference()
    
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet weak var loggedInUser: UILabel!
    @IBOutlet weak var subjectPickerView: UIPickerView!
    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var gradePickerView: UIPickerView!
    
    
    var subjects  = ["Language Arts","Social Studies","Math"]
    var grades = ["K","1", "2", "3", "4", "5", "6"]
    
    var subjectRow : Int!
    var gradeRow: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loggedInUser.text = FIRAuth.auth()!.currentUser?.displayName
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

        if (coverImageView.image == nil){
            SCLAlertView().showError("Image not Selected", subTitle: "Please Select an Image")
            return
        }
        else {
            let coverImage: UIImage = coverImageView.image!
            if let data: NSData = UIImagePNGRepresentation(coverImage) {
            
            // set upload path
                let metaData = FIRStorageMetadata()
                metaData.contentType = "image/jpg"
                self.storageRef.child("covers").child(bookName!+"-cover").putData(data, metadata: metaData){(metaData,error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    } else {
                        // store downloadURL
                        if let downloadURL = metaData?.downloadURL()!.absoluteString {
                            if bookName != "" && author != "" {
                
                                let book: [String : AnyObject] = ["title" : bookName!, "author" : author!, "subject" : subjectSelected, "grade": gradeSelected, "coverImageURL": downloadURL]
                                
                                self.rootRef.child("books").childByAutoId().setValue(book, withCompletionBlock: {(error, ref ) -> Void in
                                                    SCLAlertView().showInfo("Book Added", subTitle: "Book was successfully Added")
                                });
                                
                            }
                            else {
                                SCLAlertView().showError("Form Incomplete", subTitle: "Please fill in all the fields")
                            }

                        }
                    }
                }
            }
            
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
    
    @IBAction func addImage(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            print("Button capture")
            let imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        coverImageView.image=selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
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
