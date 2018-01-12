//
//  BookTableViewController.swift
//  ELL App
//
//  Created by Brian Carreon on 1/12/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit
import Parse

class BookTableViewController: UITableViewController {
    
    var titles = [String]()
    var authors = [String]()
    var bookPhotos = [PFFile]()
    var objectIds = [String]()
    var selectedObjectId = String()
    var selectedTitle = String()
    var users = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // logged in user
        let currentUser = PFUser.current()

        let booksQuery = PFQuery(className: "Book")
    
        booksQuery.findObjectsInBackground { (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    self.users = object["users"] as! [String]

                    // query the books from only the signed in user
                    if self.users.contains((currentUser?.username)!) {
                        self.titles.append(object["title"] as! String)
                        self.authors.append(object["author"] as! String)
                        self.bookPhotos.append(object["bookPhoto"] as! PFFile)
                        self.objectIds.append(object.objectId! as String)
                        
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func logOut(_ sender: AnyObject) {
        PFUser.logOut()
        
        DispatchQueue.main.async {
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let logInSuccessVC = Storyboard.instantiateViewController(withIdentifier: "logInView")
            self.present(logInSuccessVC, animated: true, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookTableViewCell
        
        // Configure the cell...
        
        bookPhotos[indexPath.row].getDataInBackground { (data, error) -> Void in
            if let downloadedImage = UIImage(data: data!) {
                cell.bookImage.image = downloadedImage
            }
        }
        
        cell.title.text = titles[indexPath.row]
        cell.author.text = authors[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObjectId = self.objectIds[indexPath.row]
        selectedTitle = self.titles[indexPath.row]
        performSegue(withIdentifier: "activities", sender: self)
    }
    
       // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "activities") {
            let vc = segue.destination as! ActivitiesViewController
            vc.objectId = selectedObjectId
            vc.bookTitle = selectedTitle
        }
    }
    
    
}
