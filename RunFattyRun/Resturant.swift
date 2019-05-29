//
//  Resturant.swift
//  RunFattyRun
//
//  Created by Lennart Olsen on 03/10/2017.
//  Copyright © 2017 Burger Inc. All rights reserved.
//

import CoreLocation

class Resturant {
    let name : String
    let location : CLLocation
    var distanceFrom : CLLocationDistance?
    
    init(Name : String, Location : CLLocation){
        name = Name
        location = Location
        distanceFrom = nil
    }
    
    func DistanceFrom(sourceLocation : CLLocation) -> Double{
        return sourceLocation.distance(from: location)
    }
    
    func CaloriesEstimationFrom(sourceLocation : CLLocation){
        
    }
}
