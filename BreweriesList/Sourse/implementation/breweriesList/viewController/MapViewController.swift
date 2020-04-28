//
//  MapViewController.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: BaseViewController {

    // MARK: - IBOutlet
    
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Properties
    
    public var latitude: String?
    public var longitude: String?
    public var name: String?
    
    // MARK: - Business logic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMapView()
    }
 
    // MARK: - Actions
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupMapView() {
        if let latitude = self.latitude, let lat = Double(latitude),
            let longitude = self.longitude, let lng = Double(longitude) {
            
            let initialLocation = CLLocation(latitude: lat, longitude: lng)
            let regionRadius = 1000.0
            let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            self.mapView.setRegion(coordinateRegion, animated: true)

            let beweryPlace = MKPointAnnotation()
            beweryPlace.title = name ?? ""
            beweryPlace.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            self.mapView.addAnnotation(beweryPlace)
        }
    }
}
