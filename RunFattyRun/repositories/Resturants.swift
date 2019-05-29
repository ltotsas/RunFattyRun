//
//  Resturants.Mock.swift
//  RunFattyRun
//
//  Created by Lennart Olsen on 04/10/2017.
//  Copyright © 2017 Burger Inc. All rights reserved.
//

import Foundation
import CoreLocation

/**
 * Mocked out for now
 **/
class ResturantRepository {
    init(){
        loadResturants()
    }
    func getAll() -> [Resturant] {
        return resturants
    }
    func getByDistance(currentLocation : CLLocation, minDistance : Double, maxDistance : Double) -> [Resturant]{
        /** Calculate distances on resturants **/
        for rest in resturants {
            rest.distanceFrom = currentLocation.distance(from: rest.location)
        }
        /** order by distance ascending **/
        resturants = resturants.sorted(by : {Double($0.distanceFrom!) < Double($1.distanceFrom!)})
        
        var returnValue : [Resturant] = []
        
        /** Push them into array based on distance **/
        for rest in resturants {
            if(rest.distanceFrom! > minDistance && rest.distanceFrom! < maxDistance){
                returnValue.append(rest)
            }
        }
        
        /** Previous array could be empty (most likey is) Update for performance **/
        if(returnValue.count < 1){
            for rest in resturants {
                if(rest.distanceFrom! > maxDistance){
                    returnValue.append(rest)
                    
                    return returnValue
                }
            }
        }
        
        return returnValue
    }
}

private var resturants = [Resturant]()

private func loadResturants() {
    
    resturants = [
        /** Region Hovedstaden **/
        Resturant(Name: "Mc Donalds Ballerup", Location : CLLocation(latitude: 55.722275, longitude: 12.3843229)),
        Resturant(Name: "Mc Donalds Birkerød", Location : CLLocation(latitude: 55.840972, longitude: 12.440993)),
        Resturant(Name: "Mc Donalds Frederiksund", Location : CLLocation(latitude: 55.843465, longitude: 12.075541)),
        Resturant(Name: "Mc Donalds Frederiksværk", Location : CLLocation(latitude: 55.968731, longitude: 12.029236)),
        Resturant(Name: "Mc Donalds Gentofte", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Helsingør", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Herlev", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Hillerød", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Hvidovre", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Amager", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds København (Amagerbrogade)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds København (Ellebjerg)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds København (Fisketorvet)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds København (Hovedbanegården)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds København (Kastrup)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds København (Nørrebro)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds København (Nørreport)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds København (Rådhuspladsen)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds København (Scala)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds København (Østerbro)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Rødovre", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Taastrup (City 2)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Taastrup (Mårkærvej)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Vallensbæk", Location : CLLocation(latitude: 54, longitude: 10)),
        
        /** Region Sjælland **/
        Resturant(Name: "Mc Donalds Holbæk", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Køge", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Nykøbing F", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Næstved (Blegdammen)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Næstved (Gl. Holstedvej)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Roskilde (Københavnsvej)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Roskilde (Ringstedgade)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Slagelse", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Solrød", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Ringsted", Location : CLLocation(latitude: 54, longitude: 10)),
        
        /** Region Syddanmark **/
        Resturant(Name: "Mc Donalds Esbjerg (Gjesing)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Esbjerg (Kongensgade)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Esbjerg (Storegade)", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Fredericia", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Haderslev", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Kolding", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Middelfart", Location : CLLocation(latitude: 55.510036, longitude: 9.768050)),
        Resturant(Name: "Mc Donalds Nyborg", Location : CLLocation(latitude: 55.309103, longitude: 10.806226)),
        Resturant(Name: "Mc Donalds Odense (Hjallese)", Location : CLLocation(latitude: 55.353440, longitude: 10.404405)),
        Resturant(Name: "Mc Donalds Odense (Kongensgade)", Location : CLLocation(latitude: 55.395554, longitude: 10.382424)),
        Resturant(Name: "Mc Donalds Odense (Odense Banegårdcenter)", Location : CLLocation(latitude: 55.401496, longitude: 10.387118)),
        Resturant(Name: "Mc Donalds Odense (Rosengårscenteret)", Location : CLLocation(latitude: 55.383741, longitude: 10.426444)),
        Resturant(Name: "Mc Donalds Odense (Tarup Center)", Location : CLLocation(latitude: 55.409506, longitude: 10.339169)),
        Resturant(Name: "Mc Donalds Rødekro", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Svendborg", Location : CLLocation(latitude: 55.060634, longitude: 10.600093)),
        Resturant(Name: "Mc Donalds Sønderborg", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Tønder", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Varde", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Vejen", Location : CLLocation(latitude: 54, longitude: 10)),
        Resturant(Name: "Mc Donalds Vejle (GateWay E45)", Location : CLLocation(latitude: 55.748981, longitude: 9.589442)),
        Resturant(Name: "Mc Donalds Vejle (Vinding)", Location : CLLocation(latitude: 55.674754, longitude: 9.580127)),
    ]
}
