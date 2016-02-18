//
//  ViewController.swift
//  College Profile Builder
//
//  Created by MBalsamo on 2/1/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var myTableView: UITableView!
    var colleges: [College] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        colleges.append(College(Name: "College 1", Location: "Location 1", NumberofStudents: 1408, Image: UIImage(named: "college1")!, Website: "youtube.com"))
        colleges.append(College(Name: "College 2", Location: "Location 2", NumberofStudents: 1432, Image: UIImage(named: "college")!, Website: "bing.com"))
        colleges.append(College(Name: "College 3", Location: "Location 3", NumberofStudents: 1268, Image: UIImage(named: "college2")!, Website: "yahoo.com"))
    }

    @IBAction func addButtonTapped(sender: UIBarButtonItem)
    {
        let myAlert = UIAlertController(title: "Add a College", message: nil, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        myAlert.addAction(cancelAction)
        let addAction = UIAlertAction(title: "Add", style: .Default) { (addAction) -> Void in
            let collegeNameTextField = myAlert.textFields![0] as UITextField
            let locationTextField = myAlert.textFields![1] as UITextField
            let numberOfStudentsTextField = myAlert.textFields![2] as UITextField
            let websiteTextField = myAlert.textFields! [3] as UITextField
            self.colleges.append(College(Name: collegeNameTextField.text!, Location: locationTextField.text!, NumberofStudents: Int(numberOfStudentsTextField.text!)!, Website: websiteTextField.text!))
            self.myTableView.reloadData()
        }
        myAlert.addAction(addAction)
        myAlert.addTextFieldWithConfigurationHandler { (nameTextField) -> Void in
            nameTextField.placeholder = "College Name"
        }
        myAlert.addTextFieldWithConfigurationHandler { (locationTextField) -> Void in
            locationTextField.placeholder = "Location of College"
        }
        myAlert.addTextFieldWithConfigurationHandler { (numberOfStudentsTextField) -> Void in
            numberOfStudentsTextField.placeholder = "Number of Students"
        }
        myAlert.addTextFieldWithConfigurationHandler { (websiteTextField) -> Void in
            websiteTextField.placeholder = "Website"
        }
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    @IBAction func editButtonTapped(sender: UIBarButtonItem)
    {
        myTableView.editing = !myTableView.editing
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myTableViewCell = myTableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        myTableViewCell.textLabel?.text = colleges[indexPath.row].name
        myTableViewCell.detailTextLabel?.text = colleges[indexPath.row].location
        return myTableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete
        {
            colleges.removeAtIndex(indexPath.row)
            myTableView.reloadData()
        }
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let college = colleges[sourceIndexPath.row]
        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(college, atIndex: destinationIndexPath.row)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailVC = segue.destinationViewController as! DetailViewController
        let selectRow = myTableView.indexPathForSelectedRow!.row
        detailVC.college = colleges[selectRow]
    }
}






