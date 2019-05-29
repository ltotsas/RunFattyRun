//
//  FoodListViewController.swift
//  RunFattyRun
//
//  Created by Lennart Olsen on 20/09/2017.
//  Copyright © 2017 Burger Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import HealthKit

class FoodListViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var foodDescriptionLabel: UITextView!
    @IBOutlet weak var foodPicker: UIPickerView!
    @IBOutlet weak var foodCaloriesLabel: UILabel!
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var btnFindBurger: UIButton!
    @IBOutlet weak var calLabel: UILabel!
    
    let allFood = FoodBank()
    let locationManager = CLLocationManager()
    var selectedFood : Int = 0
    
    var location : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.foodPicker.delegate = self
        self.foodPicker.dataSource = self
        foodPicker.backgroundColor? = UIColor.black
        foodPicker.selectRow((allFood.foodList.count/2)-1, inComponent: 0, animated: true)
        btnFindBurger.layer.borderWidth = 2
        btnFindBurger.layer.borderColor = UIColor.white.cgColor
        self.foodDescriptionLabel.text = allFood.foodList[(allFood.foodList.count/2)-1].description
        self.foodCaloriesLabel.text = String(allFood.foodList[(allFood.foodList.count/2)-1].calories)
        self.foodImg.image = UIImage(named:allFood.foodList[(allFood.foodList.count/2)-1].image)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        foodImg.center.x  -= view.bounds.width
        foodCaloriesLabel.center.x += view.bounds.width
        calLabel.center.x += view.bounds.width
        UIView.animate(withDuration: 0.7,delay: 0.3, options: [],
           animations: {
            self.foodImg.center.x += self.view.bounds.width
            self.foodCaloriesLabel.center.x -= self.view.bounds.width
            self.calLabel.center.x -= self.view.bounds.width
        },
           completion: nil
        )
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allFood.foodList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: allFood.foodList[row].name, attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFood = row
        updateUI()
    }
    
    @IBAction func findMeTheBurger(_ sender: Any) {
        performSegue(withIdentifier: "goToRestaurantsView", sender: self)
    }
    
    //Location Manager Delegate Methods
    /***************************************************************/
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            print("location = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            self.location = location
        }
    }

    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRestaurantsView" {
            let destinationVC = segue.destination as! ResturantTableViewController
            destinationVC.selectedFood = allFood.foodList[selectedFood]
            destinationVC.userLocation = self.location
        }
    }
    
    func updateUI() {
        self.foodDescriptionLabel.text = allFood.foodList[selectedFood].description
        self.foodCaloriesLabel.text = String(allFood.foodList[selectedFood].calories)
        self.foodImg.image = UIImage(named : allFood.foodList[selectedFood].image)
    }
}

