//
//  FruitsDataManager.swift
//  AutoScout
//
//  Created by Haneef Habib on 9/22/17.
//  Copyright © 2017 AutoScout. All rights reserved.
//

import UIKit

class TARestaurantDataManager: NSObject {
   static let shared = TARestaurantDataManager()
    
    private override init() {
        
    }
    
    func loadRestaurantList() -> [RestaurantModel]? {
        let list = TACoreDataManager.shared.fetchRestaurantList()
        
        // If list is empty then populate from file
        guard list!.count > 0 else {
            saveRestaurantListFromFile()
            return TACoreDataManager.shared.fetchRestaurantList()
        }
        
        return list
    }
    
    func saveRestaurantListFromFile(){
        
        if let restaurantListData = geRestaurantDataFromlocalFile() {
            TACoreDataManager.shared.saveRestaurantList(restaurantDataArray: restaurantListData)
        }
    }
    
    private func geRestaurantDataFromlocalFile()-> [[String : Any]]? {
        
        var restaurantList : [[String : Any]]?
        do {
            if let file = Bundle.main.url(forResource: "take_away", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonData = json as? [String: Any] {
                    if let restaurantsData = jsonData["restaurants"] as? [[String : Any]] {
                        restaurantList = restaurantsData
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return restaurantList
    }
    

    
    
    func loadDataWithCompletion(completion :@escaping ([TARestaurant]? ,Error?)->Void){
        
        print("\(loadRestaurantList()!.count)")

        var restaurantList : [TARestaurant]?
        var errorData:Error?
        do {
            if let file = Bundle.main.url(forResource: "take_away", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonData = json as? [String: Any] {
                    if let restaurantsData = jsonData["restaurants"] as? [[String : Any]] {
                        restaurantList = [TARestaurant]()
                        for restaurant in restaurantsData {
                            let restaurantModel = TARestaurant.init(dictionary: restaurant)
                            restaurantList!.append(restaurantModel)
                        }
                    }
                }
            }
        } catch {
            errorData = error
            print(error.localizedDescription)
        }
        completion(restaurantList,errorData)
    }
}
