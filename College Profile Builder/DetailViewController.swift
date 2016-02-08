//
//  DetailViewController.swift
//  College Profile Builder
//
//  Created by MBalsamo on 2/1/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController, SFSafariViewControllerDelegate {
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var studentsTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    var college: College!

    override func viewDidLoad() {
        super.viewDidLoad()
        myImage.image = college.image
        nameTextField.text = college.name
        locationTextField.text = college.location
        studentsTextField.text = String(college.numberOfStudents)
        
    }
    @IBAction func saveButton(sender: UIButton)
    {
        college.numberOfStudents = Int(studentsTextField.text!)!
        college.name = nameTextField.text!
        college.location = locationTextField.text!
        college.image = myImage.image!
    }

    @IBAction func websiteButton(sender: UIButton)
    {
        
        let myURL = NSURL(string: "https://google.com")
        let svc = SFSafariViewController(URL: myURL!)
        svc.delegate = self
        presentViewController(svc, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}
