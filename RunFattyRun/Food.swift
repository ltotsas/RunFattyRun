//
//  food.swift
//  RunFattyRun
//
//  Created by Lennart Olsen on 20/09/2017.
//  Copyright © 2017 Burger Inc. All rights reserved.
//

class Food {
    let name : String
    let description : String?
    let calories : Int
    let image : String/** Should be a reference to the burger image **/
    
    init(foodName: String, foodDescription: String, foodCalories: Int, foodImage: String) {
        name = foodName
        description = foodDescription
        calories = foodCalories
        image = foodImage
    }
    
    func getCalorieDistance() -> Double {
        return Double(self.calories * 10)
    }
}

