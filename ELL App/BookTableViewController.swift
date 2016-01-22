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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var booksQuery = PFQuery(className: "Book")
    
        booksQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    self.titles.append(object["title"] as! String)
                    self.authors.append(object["author"] as! String)
                    self.bookPhotos.append(object["bookPhoto"] as! PFFile)
                    self.objectIds.append(object.objectId! as String)
                    
                    self.tableView.reloadData()
                }
                
                //print(self.titles)
                //print(self.authors)
                //print(self.bookPhotos)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BookTableViewCell
        
        // Configure the cell...
        
        bookPhotos[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
            if let downloadedImage = UIImage(data: data!) {
                cell.bookImage.image = downloadedImage
            }
        }
        
        cell.title.text = titles[indexPath.row]
        cell.author.text = authors[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedObjectId = self.objectIds[indexPath.row]
        selectedTitle = self.titles[indexPath.row]
        performSegueWithIdentifier("activities", sender: self)
    }
    
       // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "activities") {
            var vc = segue.destinationViewController as! ActivitiesViewController
            vc.objectId = selectedObjectId
            vc.bookTitle = selectedTitle
        }
    }
    
    
}
