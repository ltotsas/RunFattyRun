//
//  ResturantTableViewController.swift
//  RunFattyRun
//
//  Created by Lennart Olsen on 03/10/2017.
//  Copyright © 2017 Burger Inc. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

/**
 * TODO : Could be a UITableViewController, but creates sporadic errors
 * For more info see https://medium.com/@jeremysh/creating-a-sticky-header-for-a-uitableview-40af71653b55
 **/
private let kTableHeaderHeight : CGFloat = 191.0
class ResturantTableViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate {
    
    var searchForBurger : Int?
    var selectedFood : Food?
    var selectedResturant : Resturant?
    var resturantList : [Resturant] = []
    var headerView : UIView!
    var userLocation : CLLocation?
    /** TableView and HeaderView **/
    @IBOutlet weak var map: UIImageView!
    @IBOutlet weak var txtDescr: UITextView!
    @IBOutlet var tableView : UITableView!
    @IBAction func unwindToRestaurants(segue:UIStoryboardSegue) { }

    var allFoods = FoodBank()
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top:kTableHeaderHeight,left:0, bottom:0,right:0)
        tableView.contentOffset = CGPoint(x:0, y:-kTableHeaderHeight)
        updateHeaderView()
        updateTableListView()
    }
    
    override func viewWillAppear(_ animated : Bool) {
        super.viewWillAppear(animated)
        map.center.x  -= view.bounds.width
        txtDescr.center.x += view.bounds.width
        UIView.animate(withDuration: 0.7,delay: 0.5, options: [],
                       animations: {
                        self.map.center.x += self.view.bounds.width
                        self.txtDescr.center.x -= self.view.bounds.width
        },
                       completion: nil
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToChaseTheBurgerView" {
            let destinationVC = segue.destination as! ChaseTheBurgerViewController
            if let food = selectedFood {
                destinationVC.selectedFood = food
            }
            if let resturant = selectedResturant {
                destinationVC.selectedResturant = resturant
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedResturant = resturantList[indexPath.row]
        self.performSegue(withIdentifier: "goToChaseTheBurgerView", sender: self)
    }
    
    func getOrderedResturants(resturants : [Resturant]? ){
        // Source Coordinates
        let sourceCoordinates = userLocation?.coordinate
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        if let rests = resturants {
            for rest in rests {
                // Destination Coordinates
                
                let destPlacemark = MKPlacemark(coordinate: rest.location.coordinate)
                let destItem = MKMapItem(placemark: destPlacemark)
                
                let directionRequest = MKDirectionsRequest()
                directionRequest.source = sourceItem
                directionRequest.destination = destItem
                directionRequest.transportType = .walking
                
                let directions = MKDirections(request: directionRequest)
                directions.calculate(completionHandler: {
                    response, error in
                    
                    guard let response = response else {
                        if let error = error {
                            print("Could not get proper directions: " + error.localizedDescription)
                        }
                        return
                    }
                    
                    let route = response.routes[0]
                    
                    rest.distanceFrom = route.distance
                    
                    if let food = self.selectedFood {
                        NSLog("\(food.name) is ok with \(route.distance) >= \(food.getCalorieDistance()) -> \(route.distance >= food.getCalorieDistance())")
                        if(route.distance >= food.getCalorieDistance() ){
                            self.addResturantToList(resturant : rest)
                        }
                    }
                    
                })
            }
        }
        
    }

    func updateTableListView() {
        NSLog("resturantList length \(resturantList.count)")
        resturantList.removeAll()
        tableView.reloadData()
        
        if let loc = userLocation {
            if let food = selectedFood {
                let resturants = ResturantRepository().getByDistance(currentLocation : loc,
                                                                     minDistance : food.getCalorieDistance() * 0.9,
                                                                     maxDistance: food.getCalorieDistance() * 2)
                NSLog("Resutrant count \(resturants.count)")
                getOrderedResturants(resturants: resturants)
                
            }
        }
    }
    
    func addResturantToList(resturant : Resturant){
        self.resturantList.append(resturant)
        
        let row = resturantList.count - 1
        let indexPath = IndexPath(row : row, section : 0 )
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
    
    func updateHeaderView() {
        var headerRect = CGRect(x:0, y: -kTableHeaderHeight, width:tableView.bounds.width,height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}

extension ResturantTableViewController:UITableViewDataSource {
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "ResturantTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ResturantTableViewCell else {
            fatalError("Holy smack")
        }
        let resturant = resturantList[indexPath.row]
        if let label = cell.nameLabel{
            label.text = resturant.name
        } else {
            cell.textLabel?.text = resturant.name
        }
        
        return cell
    }
    
}
