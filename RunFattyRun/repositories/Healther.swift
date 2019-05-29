//
//  Healther.swift
//  RunFattyRun
//
//  Created by Lennart Olsen on 11/10/2017.
//  Copyright © 2017 Burger Inc. All rights reserved.
//

import Foundation

import HealthKit

class Healther {
    
    let today           : Date
    let yesterday       : Date
    let healtkitStore   : HKHealthStore
    init(store : HKHealthStore){
        self.today = Date()
        self.yesterday = Date()
        
        self.healtkitStore = store
        
    }
    
    func retrieveStepCount(completion: @escaping (_ stepRetrieved: Double) -> Void) {
        
        //   Define the Step Quantity Type
        let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        //   Get the start of the day
        let date = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)
        
        //  Set the Predicates & Interval
        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)
        var interval = DateComponents()
        interval.day = 1
        
        //  Perform the Query
        let query = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate as Date, intervalComponents:interval)
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                print("Got some error", error)
                //  Something went Wrong
                return
            }
            
            if let myResults = results{
                myResults.enumerateStatistics(from: self.yesterday, to: self.today) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        
                        print("Steps = \(steps)")
                        completion(steps)
                        
                    }
                }
            }
            
            
        }
        
        healtkitStore.execute(query)
    }
}
