//
//  foodBank.swift
//  RunFattyRun
//
//  Created by Lazaros Totsas on 29/09/2017.
//  Copyright © 2017 Burger Inc. All rights reserved.
//

import Foundation

class FoodBank {
    
    var foodList = [Food]()
    
    init() {
        // List obtained from: https://www.mcdonalds.com/us/en-us/about-our-food/nutrition-calculator.html
        
        foodList.append(Food(foodName: "Hamburger", foodDescription : "A juicy, 100% pure beef burger patty topped with a tangy pickle, chopped onions, ketchup and mustard. Our simple, juicy hamburgers are made with absolutely no fillers, additives or preservatives, and seasoned with just a pinch of salt and pepper.",                                           foodCalories : 250, foodImage : "t-mcdonalds-Hamburger.png"))
        
        foodList.append(Food(foodName: "Cheeseburger", foodDescription : "A juicy, 100% pure beef patty with absolutely no fillers, additives or preservatives, seasoned with a pinch of salt and pepper, and topped with a tangy pickle, chopped onions, ketchup, mustard, and a slice of melty American cheese.",                                        foodCalories : 300, foodImage : "t-mcdonalds-Cheeseburger.png"))
        
        foodList.append(Food(foodName: "McDouble®", foodDescription : "McDouble® burger features two 100% pure beef patties with absolutely no fillers, additives or preservatives, seasoned with a pinch of salt and pepper, and topped with tangy pickles, chopped onions, ketchup, mustard and a slice of melty American cheese.",                                           foodCalories : 380, foodImage : "t-mcdonalds-McDouble.png"))
        
        foodList.append(Food(foodName: "Double Cheeseburger", foodDescription : "Double Cheeseburger features two 100% pure beef patties with absolutely no fillers, additives or preservatives, seasoned with a pinch of salt and pepper, and topped with tangy pickles, chopped onions, ketchup, mustard and two slices of melty merican cheese.",                                 foodCalories : 430, foodImage : "t-mcdonalds-Double-Cheeseburger.png"))
        
        foodList.append(Food(foodName: "Big Mac®", foodDescription : "Mouthwatering perfection starts with two sear-sizzled 100% pure beef patties and Big Mac® sauce, sandwiched between a sesame seed bun. American cheese, shredded lettuce, onions and pickles top it off.",                                            foodCalories : 540, foodImage : "t-mcdonalds-Big-Mac.png"))
        
        foodList.append(Food(foodName: "Quarter Pounder® with Cheese", foodDescription : "Quarter Pounder® with Cheese burger features a ¼ lb.* of 100% pure beef with absolutely no fillers, additives or preservatives. Just a pinch of salt and pepper, and seared on our grills so it’s thick and juicy. Layered with two slices of melty American cheese, slivered onions and tangy pickles on a sesame seed bun.",                        foodCalories : 530, foodImage : "t-mcdonalds-Quarter-Pounder-with-Cheese.png"))
        
        foodList.append(Food(foodName: "Pico Guacamole with 100% Pure Beef 1/4 lb. Patty", foodDescription : "Layered with guacamole made with real Hass avocados; freshly-prepared Pico de Gallo made with Roma tomatoes, onions, and the flavors of lime and cilantro; creamy buttermilk ranch sauce; smooth white cheddar*; and crisp leaf lettuce. On a 1/4 lb.** of 100% pure beef with absolutely no fillers, additives or preservatives. Choose an artisan roll or sesame seed bun.",                   foodCalories : 580, foodImage : "t-mcdonalds-picoguac-sesame.png"))
        
        foodList.append(Food(foodName: "Signature Sriracha 1/4 lb. Burger", foodDescription : "Layered with spicy, chili pepper-infused Sriracha Mac Sauce™, tender baby greens, tomato, crispy onion, and smooth white cheddar*. Just the right amount of Sriracha Mac Sauce™ kick makes for a pleasantly spicy burger. On a 1/4 lb.** of 100% pure beef with absolutely no fillers, additives or preservatives. Choose an artisan roll or sesame seed bun.",                   foodCalories : 670, foodImage : "t-mcdonalds-sriracha-burger.png"))
        
        foodList.append(Food(foodName: "Sweet BBQ Bacon with 100% Pure Beef 1/4 lb. Patty", foodDescription : "Layered with BBQ sauce made with sweet onions, thick-cut Applewood smoked bacon, grilled & crispy onions, and smooth white cheddar*. On a 1/4lb.** of 100% pure beef with absolutely no fillers, additives, or preservatives. Choose an artisan roll or sesame seed bun.",   foodCalories : 700, foodImage : "t-mcdonalds-sweetbbqbacon-sesame.png"))
        
        foodList.append(Food(foodName: "Double Quarter Pounder® with Cheese", foodDescription : "Two quarter pound( Ingredients 100% Pure USDA Inspected Beefñ No Fillers, No Extenders. Prepared with Grill Seasoning) Salt, Black Pepper. Layered with two slices of melty cheese, slivered onions and tangy pickles on sesame seed bun.",                 foodCalories : 770, foodImage : "t-mcdonalds-Double-Quarter-Pounder-with-Cheese.png"))
    }
}
