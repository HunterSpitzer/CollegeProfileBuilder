//
//  College.swift
//  College Profile Builder
//
//  Created by MBalsamo on 1/25/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class College: NSObject
{
    var name = ""
    var location = ""
    var numberOfStudents = 0
    var image = UIImage(named: "default")
    var website = NSURL(string: "www.google.com")
    
    
    init(Name: String, Location: String, NumberofStudents: Int, Image: UIImage, Website: NSURL) {
        super.init()
        name = Name
        location = Location
        numberOfStudents = NumberofStudents
        image = Image
        website = Website
    }
    init(Name: String, Location: String, NumberofStudents: Int, Website: NSURL) {
        super.init()
        name = Name
        location = Location
        numberOfStudents = NumberofStudents
        website = Website
        
    }
    
    

}
