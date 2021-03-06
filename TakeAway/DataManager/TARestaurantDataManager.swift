//
//  TARestaurantDataManager.swift
//  TakeAway
//
//  Created by Haneef Habib on 9/26/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import UIKit
//@testable import TakeAway

class TARestaurantDataManager: NSObject {
    
    func loadRestaurantList() -> [RestaurantModel]? {
        // If list is empty then populate from file
        guard let restList = TACoreDataManager.shared.fetchRestaurantList() ,  restList.count > 0 else {
            saveRestaurantListFromFile()
            return TACoreDataManager.shared.fetchRestaurantList()
        }        
        return restList
    }
    
    func saveResults() {
        TACoreDataManager.shared.saveContext()
    }
    
    func saveRestaurantListFromFile(){
        
        if let restaurantJsonData = geRestaurantJsonDataFromlocalFile() {
            TACoreDataManager.shared.saveRestaurantList(jsonData: restaurantJsonData)
        }
    }
    
    func geRestaurantJsonDataFromlocalFile()-> [String : Any]? {
        var restaurantJsonData : [String : Any]?
        do {
            if let file = Bundle.main.url(forResource: "take_away", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                restaurantJsonData = json as? [String : Any]
            }
        } catch {
            print(error.localizedDescription)
        }
        return restaurantJsonData
    }
}
