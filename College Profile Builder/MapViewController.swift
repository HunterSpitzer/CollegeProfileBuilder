//
//  MapViewController.swift
//  College Profile Builder
//
//  Created by MBalsamo on 2/18/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myTextView: UITextField!
    let myLocationManager = CLLocationManager()
    var theLocation : College!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLocationManager.delegate = self
        myLocationManager.requestAlwaysAuthorization()
        myLocationManager.startUpdatingLocation()
        
        myMapView.delegate = self
        myMapView.showsUserLocation = true
        myMapView.userLocation.title = "My Location"
        geoCodeLocation(theLocation.name)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(myLocationManager.location)
    }
    
    @IBAction func myButtonTapped(sender: UIButton)
    {
        geoCodeLocation(myTextView.text!)
        myTextView.resignFirstResponder()
    
    }
    func displayMap(MyPlaceMark: CLPlacemark) {
        let myLocation = MyPlaceMark
        let mySpan = MKCoordinateSpanMake(0.05, 0.05)
        let myRegion = MKCoordinateRegionMake((myLocation.location?.coordinate)!, mySpan)
        myMapView.setRegion(myRegion, animated: true)
        let myPin = MKPointAnnotation()
        myPin.coordinate = (myLocation.location?.coordinate)!
        myPin.title = MyPlaceMark.name
        myMapView.addAnnotation(myPin)
        myTextView.text = MyPlaceMark.name
    }
    
    func geoCodeLocation(MySearch: String) {
        let myGeoCode = CLGeocoder()
        myGeoCode.geocodeAddressString(MySearch) { (var placemarks, error) -> Void in
            if error != nil {
                print("Error")
            } else {
                self.displayMap((placemarks?.first)!)
            }
            if placemarks!.count  > 1 {
                let myAlert = UIAlertController(title: "Which Place?", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
                let cancelAction = UIAlertAction(title: "Cancel", style:  UIAlertActionStyle.Cancel, handler: nil)
                myAlert.addAction(cancelAction)
                
                for each in placemarks! {
                    myAlert.addAction(UIAlertAction(title: (each.name), style: .Default, handler: { (buttonClicked) -> Void in
                        self.displayMap(each)
                    }))
                    self.myMapView.reloadInputViews()
                }
                self.presentViewController(myAlert, animated: true, completion: nil)
            }
        }
    }

    
}
