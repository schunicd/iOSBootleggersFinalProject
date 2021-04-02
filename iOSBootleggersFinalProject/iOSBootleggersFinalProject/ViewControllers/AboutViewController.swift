//
//  AboutViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by  on 4/2/21.
//

import UIKit
import MapKit

class AboutViewController: UIViewController {
    
    var name : String = "The Moonshine Cafe"
    var lat : CLLocationDegrees = 43.440554
    var long : CLLocationDegrees = -79.675639
    
    @IBOutlet weak var mapView: MKMapView!
    
    func loadLocation(){
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        mapView.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocation()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
