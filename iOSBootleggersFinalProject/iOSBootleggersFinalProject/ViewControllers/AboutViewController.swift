//
//  AboutViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by Mohammed Musleh on 4/2/21.
//

import UIKit
import MapKit //importing the MapKit

class AboutViewController: UIViewController {
    //defining the tag, longitute and latitude for the Moonshine Cafe
    var name : String = "The Moonshine Cafe" //
    var lat : CLLocationDegrees = 43.440554
    var long : CLLocationDegrees = -79.675639
    
    @IBOutlet weak var mapView: MKMapView! //IBOutlet to the Mapview on our Main.storyboard
    
    //function to load the location into the map view
    func loadLocation(){
        //create the annotation variable, assign the name variable to the title
        //add the coordinates to the annotation
        //We could stop there and the mapkit would work, but it would begin at a world map level view.
        //Adding the region variable and setting the setting the lat and long to 2.5km gives a good view of the location and the area
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
        //add the region and annotation to the mapview
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        mapView.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocation()//call the loadLocation function on load
        // Do any additional setup after loading the view.
    }
    

}
