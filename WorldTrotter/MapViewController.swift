//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Ceasar Barbosa on 3/5/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //MARK: Global Variables
    
    private var mapView: MKMapView!
    private var counter = 0
    private var locationManager = CLLocationManager()


    //MARK: Load View
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        let margins = view.layoutMarginsGuide

        
        
        // Segment Control View Object
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        
            segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            segmentedControl.addTarget(self, action: "mapTypeChanged:", forControlEvents: .ValueChanged)
        
        self.view.addSubview(segmentedControl)
        
        // Segment Constraints
        segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8).active = true
        segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true

        
        
        // Pin Drop Button View Object
        let pinDropButton = UIButton(type: .System)

            pinDropButton.setTitle("Pin Drop", forState: .Normal)
            pinDropButton.tintColor = UIColor.blackColor()
            pinDropButton.backgroundColor = UIColor.redColor()
            pinDropButton.layer.cornerRadius = 5
            pinDropButton.layer.borderColor = UIColor.blackColor().CGColor
            pinDropButton.layer.borderWidth = 2
        
            pinDropButton.addTarget(self, action: "dropPins", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(pinDropButton)
        
        // Pin Drop Button Constraints
        pinDropButton.translatesAutoresizingMaskIntoConstraints = false
        pinDropButton.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        pinDropButton.topAnchor.constraintEqualToAnchor(segmentedControl.bottomAnchor, constant: 16).active = true
        pinDropButton.heightAnchor.constraintEqualToAnchor(nil, constant: 40).active = true
        pinDropButton.widthAnchor.constraintEqualToAnchor(nil, constant: 80).active = true


        
    }
    
    //MARK: View Did Load
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Delegate
        locationManager.delegate = self
        mapView.delegate = self
        
        // Show user location
        mapView.showsUserLocation = true
        
        print("MapViewController loaded its view")
    }
    
    
    //MARK: Created Functions
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    
    func dropPins() {
        let bornAnnotation = MKPointAnnotation()
            bornAnnotation.coordinate = CLLocationCoordinate2DMake(41.863559, -87.934871)
            bornAnnotation.title = "Born Here!"


        let wrigleyField = MKPointAnnotation()
            wrigleyField.coordinate = CLLocationCoordinate2DMake(41.9483, -87.655334)
            wrigleyField.title = "Wrigley!"


        let grandCanyon = MKPointAnnotation()
            grandCanyon.coordinate = CLLocationCoordinate2DMake(36.1000, -112.1000)
            grandCanyon.title = "Grand Canyon!"
        
        // Drop annotation everytime button is tapped
        if self.counter == 0 || self.counter > 3 {
            self.mapView.removeAnnotation(wrigleyField)
            self.counter = 0
            print("Button tapped")
            self.mapView.addAnnotation(bornAnnotation)
        } else if self.counter == 1 {
            print("Button tapped again")
            self.mapView.addAnnotation(wrigleyField)
        } else if self.counter == 2 {
            print("Button tapped again again")
            self.mapView.addAnnotation(grandCanyon)
        } else  {
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
        
        self.counter++
        
    }
    
    
    //MARK: Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        mapView.setRegion(MKCoordinateRegionMake(view.annotation!.coordinate, MKCoordinateSpan(latitudeDelta: 0.005,longitudeDelta: 0.005)), animated: true)

    }


    
    
    

    
    
    
    
    
    
    
    
    
    
    
}