//
//  DetailViewController.swift
//  College Profile Builder
//
//  Created by MBalsamo on 2/1/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController, SFSafariViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var studentsTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    var college: College!
    let imagePicker = UIImagePickerController()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.redColor()
        let locate : String = locationTextField.text!

        myImage.image = college.image
        nameTextField.text = college.name
        locationTextField.text = college.location
        studentsTextField.text = String(college.numberOfStudents)
        websiteTextField.text = String(college.website)
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    @IBAction func saveButton(sender: UIButton)
    {
        college.numberOfStudents = Int(studentsTextField.text!)!
        college.name = nameTextField.text!
        college.location = locationTextField.text!
        college.image = myImage.image!
        college.website = websiteTextField.text!
    }

    @IBAction func websiteButton(sender: UIButton)
    { 
        
        let myUrl = NSURL(string: "https://\(college.website)")
        let svc = SFSafariViewController(URL: myUrl!)
        svc.delegate = self
        presentViewController(svc, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pictureButton(sender: UIBarButtonItem)
    {
        let mySheet = UIAlertController(title: "Choose Your Picture for this College", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        mySheet.addAction(UIAlertAction(title: "Library of Photos", style: .Default, handler: { (libraryAction) -> Void in
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }))
        
        presentViewController(mySheet, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true) { () -> Void in
            self.myImage.image = (info[UIImagePickerControllerEditedImage] as! UIImage)
    }
}
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let mapVC = segue.destinationViewController as! MapViewController
        mapVC.theLocation = college
       }
    
}

