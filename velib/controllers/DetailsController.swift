//
//  DetailsController.swift
//  velib
//
//  Created by Clément SAUVAGE on 30/10/2017.
//  Copyright © 2017 Clément SAUVAGE. All rights reserved.
//

import UIKit

import MapKit
import CoreLocation

class DetailsController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var station: Station?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        
        if let coordinates = station?.position {
            
            let camera = MKMapCamera.init(lookingAtCenter: coordinates,
                                          fromEyeCoordinate: coordinates, eyeAltitude: 200)
            
            map.setCamera(camera, animated: true)
            
            
            var information = MKPointAnnotation()
            information.coordinate = coordinates
            information.title = station?.nameString
            information.subtitle = "\(station!.availableBikes) Vélib sur \(station!.availableSpot) disponibles"
            
            map.addAnnotation(information)
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "BikeIdentifier"
        
        var annotationView: MKAnnotationView?
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation,
                                              reuseIdentifier: annotationIdentifier)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "pinImage")
        }
        
        return annotationView
        
    }

}
