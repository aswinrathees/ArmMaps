//
//  ViewController.swift
//  ArmMaps
//
//  Created by Aswin R on 21/04/24.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        updateUserPin()
    }
    
    @IBAction func addLocation(_ sender: Any) {
        guard let coordinates = locationManager.location?.coordinate else { return }
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        
        AppDefaults.shared.latitude = latitude
        AppDefaults.shared.longitude = longitude
        
        updateUserPin()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            updateMaps()
        case .denied:
            print("Denied")
        case .notDetermined:
            print("Not Determined")
        case .restricted:
            print("Restricted")
        @unknown default:
            print("Unknown")
        }
    }
    
    private func updateUserPin() {
        let annotationList = mapView.annotations.filter{$0 !== mapView.userLocation}
        mapView.removeAnnotations(annotationList)
        
        let location = AppDefaults.shared.getLastLocation()
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        annotation.title = "Current Location"
        annotation.subtitle = "This is the last location you saved"
        mapView.addAnnotation(annotation)
    }
    
    private func updateMaps() {
        mapView.showsUserLocation = true
    }
}

