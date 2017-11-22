//
//  Bike.swift
//  velib
//
//  Created by Clément SAUVAGE on 30/10/2017.
//  Copyright © 2017 Clément SAUVAGE. All rights reserved.
//

import UIKit
import CoreLocation
import ObjectMapper

class Station: NSObject, Mappable {
    
    var isOpened: Bool = true
    var nameString: String = ""
    var addressString: String = ""
    
    var availableSpot: Int = 20
    var availableBikes: Int = 6
    
    var position: CLLocationCoordinate2D?
    
    init(name: String, address: String) {
        
        nameString = name
        addressString = address
        
        position = CLLocationCoordinate2DMake(48.8199419657, 2.36507858639)

    }
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        nameString <- map["fields.name"]
        addressString <- map["fields.address"]
        availableSpot <- map["fields.available_bike_stands"]
        availableBikes <- map["fields.available_bikes"]
        
        var latitude: Double = 0
        var longitude: Double = 0
        
        latitude <- map["fields.position.0"]
        longitude <- map["fields.position.1"]
        
        position = CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    
    
    
    
    

}
