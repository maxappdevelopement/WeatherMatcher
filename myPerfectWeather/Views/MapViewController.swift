//
//  MapViewController.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-08.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, SaveUserCustomization {

    func savedUserCustomization(parameters: [Parameter]) {
        savedParameters = parameters
    }
    
    var savedParameters : [Parameter] = [] //for saving data when pressed back

    @IBOutlet var longTapLabel: UILabel!
    @IBOutlet var map: MKMapView!
    var manager = CLLocationManager()
    var locationInformation : String = ""
    
    var latitude : Double = 0
    var longitude : Double = 0
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get place details to display on map, if user has other positions with method from memorable places
        
        map.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization() //hur requestar jag bara en gång?
        manager.startUpdatingLocation()
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.longPress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 1.6
        map.addGestureRecognizer(uilpgr)
        
        
    }
    
    @objc func longPress(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
          
            let touchPoint = gestureRecognizer.location(in: self.map)
            
            let newCoordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
            
            let annotation = Pin(title: "FetchWeather", locationName: "Customize", discipline: "Whoknows", coordinate: newCoordinate)
            
            //annotation.coordinate = newCoordinate
           // annotation.title = "FetchWeather" //kanske user får sätta sitt eget namn här?
            map.delegate = self
            map.addAnnotation(annotation)
            map.view(for: annotation)?.isHidden = true
            map.selectAnnotation(annotation, animated: true)
            
            latitude = annotation.coordinate.latitude
            longitude = annotation.coordinate.longitude
            
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    if let placemark = placemarks?[0] {
                        
                        if placemark.subThoroughfare != nil {
                            
                            print("\(placemark.subThoroughfare!)")
                            
                        }
                        
                        if placemark.thoroughfare != nil {
                            
                           print("\(placemark.thoroughfare!)")
                            
                        }
                        
                        if placemark.subLocality != nil {
                            
                           self.locationInformation += placemark.subLocality! + "\n"
                            
                        }
                        
                        if placemark.subAdministrativeArea != nil {
                            
                           self.locationInformation += placemark.subAdministrativeArea! + "\n"
                            
                        }
                        
                        if placemark.country != nil {
                            
                           self.locationInformation += placemark.country! + "\n"
                            
                        }
                        
                    }
                    
                }
            
        })
    }
            
}
        
        //Information to send to next controller
        //PopUp
        //Do you want to set preferences for chosen location?
        // Yes
        // Cancel / No, choose another location
        

//Set up so that mapView starts from userPosition------------------------------------
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta: CLLocationDegrees = 0.1
        let lonDelta: CLLocationDegrees = 0.1
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.map.setRegion(region, animated: true)
        
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "parameter" {
           
            let parameterController : ParameterTableViewController = segue.destination as! ParameterTableViewController
            
            print(longitude)
            print(latitude)
            
            let backItem = UIBarButtonItem()
            backItem.title = "Change position"
            navigationItem.backBarButtonItem = backItem
            
            parameterController.delegate = self
            parameterController.parameters = savedParameters
                
            parameterController.latitude = latitude
            parameterController.longitude = longitude
        }
        
        
    }
    

}


extension MapViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("Does this even get called?") // 2
        guard let annotation = annotation as? Pin else { return nil }
        
        
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        }
  
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return view
        }
}

