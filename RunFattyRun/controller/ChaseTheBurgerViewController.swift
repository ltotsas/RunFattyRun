//
//  ChaseTheBurgerViewController.swift
//  RunFattyRun
//
//  Created by Lazaros Totsas, implemented by Robert Koszewski on 30/09/2017.
//  Copyright © 2017 Burger Inc. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ChaseTheBurgerViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var selectedFood : Food?
    var selectedResturant : Resturant?
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var destItem : MKMapItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup Map View
        mapView.delegate = self
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsPointsOfInterest = true
        mapView.showsUserLocation = true
        
        // Location Manager - Requests
        //locationManager.requestAlwaysAuthorization() // Interesting for later
        locationManager.requestWhenInUseAuthorization()
        
        // Start Location Services
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        // Source Coordinates
        let sourceCoordinates = locationManager.location?.coordinate
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        
        // Destination Coordinates
        var destCoordinates = CLLocationCoordinate2DMake(55.395804, 10.337553) /** Dummy cordinates **/
        print(destCoordinates)
        if let rest = selectedResturant {
            destCoordinates = rest.location.coordinate
            print(destCoordinates)
        }
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        destItem = MKMapItem(placemark: destPlacemark)
        
        // Place Burger Placemark
        let annotation = MKPointAnnotation()
        annotation.coordinate = destCoordinates
        annotation.title = "Title"
        mapView.addAnnotation(annotation)
        
        // Direction Request
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .walking
        NSLog("Got User " + String(describing : sourceCoordinates) + " BURGER " + String(describing : destCoordinates) )
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            
            guard let response = response else {
                if let error = error {
                    print("Could not get proper directions: "+error.localizedDescription)
                    NSLog(String(describing: error))
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)

            if let dlbl = self.distanceLabel {
                dlbl.text = self.roundDistance(distance: route.distance) + " KM"
            }
            let rekt = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
            
        })
    }
    
    // MapView - Location Line
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    // MapView - Location Pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = resizeImage(image:UIImage(named: "burger_256")!, newWidth: 32)
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }

    func updateDirections(_ sourceCoordinates: CLLocation){
        // Source Placemark
        let sourcePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: sourceCoordinates.coordinate.latitude, longitude: sourceCoordinates.coordinate.longitude))
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        
        // Direction Request
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .walking
        //NSLog("Got User " + String(describing : sourceCoordinates) + " BURGER " + String(describing : destCoordinates) )
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            
            guard let response = response else {
                if let error = error {
                    print("Could not get proper directions: "+error.localizedDescription)
                    NSLog(String(describing: error))
                }
                return
            }
            
            let route = response.routes[0]
            // Remove Old Overlay
            self.mapView.removeOverlays(self.mapView.overlays)
            
            // Add new overlay
            self.mapView.add(route.polyline, level: .aboveRoads)
            if let dlbl = self.distanceLabel {
                dlbl.text = self.roundDistance(distance: route.distance) + " KM"
            }
        })
    }
    
    // Called when Location is Updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        let long = userLocation.coordinate.longitude
        let lat = userLocation.coordinate.latitude
        //let distance = selectedResturant?.DistanceFrom(sourceLocation: userLocation)
        //distanceLabel.text = roundDistance(distance: distance!) + " KM" // Estimation
        
        // Update Diretions
        updateDirections(userLocation);

        print("LATLON: \(long), \(lat)")
    }
    
    // Rounding to 3 decimal places
    private func roundDistance(distance: Double) -> String{
        //return String(Double(round(1000 * (distance / 1000)) / 1000))
        return String(Double(round(distance) / 1000))
    }
    
    
    /*
     Bind to back button to open restaurants list
     without creating new view
     */
    @IBAction func goBackToRestaurants(_ sender: Any) {
        performSegue(withIdentifier: "unwindToRestaurants", sender: self)
    }
    
    /*
    func zoomToRegion() {
        let location = CLLocationCoordinate2D(latitude: 13.03297, longitude: 80.26518)
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        mapView.setRegion(region, animated: true)
    }
     */

    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
  
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let food = selectedFood {
            caloriesLabel.text = "Calories : \(food.calories)"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
