//
//  TACoreDataManager.swift
//  TakeAway
//
//  Created by Haneef Habib on 9/26/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import UIKit
import CoreData

class TACoreDataManager: NSObject {

    static let shared = TACoreDataManager()
    private override init() {
        
    }
    
    
    func fetchRestaurantList()-> [RestaurantModel]? {
        let context = persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<RestaurantModel> = RestaurantModel.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            return results
        }
        catch {
            return nil
        }
    }
    
    
    func saveRestaurantList(jsonData : [String : Any]?){
        
        let context = persistentContainer.viewContext
        if let dictionary = jsonData {
            if let restaurantDataArray = dictionary["restaurants"] as? [[String : Any]] {
                for restaurantData in restaurantDataArray {
                    let restaurantModel = NSEntityDescription.insertNewObject(forEntityName: "RestaurantModel", into: context) as! RestaurantModel
                    if let restaurantName = restaurantData["name"] as?  String {
                        restaurantModel.name = restaurantName
                    }
                    
                    if let restStatus = restaurantData["status"] as? String {
                        restaurantModel.status = restStatus
                        switch restStatus {
                        case "open":
                            restaurantModel.statusCode = 1
                        case "order ahead":
                            restaurantModel.statusCode = 2
                        default:
                            restaurantModel.statusCode = 3
                        }
                    }
                    
                    if let sortingValues = restaurantData["sortingValues"] as? [String : Any]{
                        
                        if let value = sortingValues["bestMatch"] as? Double {
                            restaurantModel.bestMatch = value
                        }
                        if let value = sortingValues["newest"] as? Double {
                            restaurantModel.newest = value
                        }
                        
                        if let value = sortingValues["ratingAverage"] as? Double {
                            restaurantModel.ratingAverage = value
                        }
                        
                        if let value = sortingValues["distance"] as? Double {
                            restaurantModel.distance = value
                        }
                        
                        if let value = sortingValues["averageProductPrice"] as? Double {
                            restaurantModel.averageProductPrice = value
                        }
                        
                        if let value = sortingValues["deliveryCosts"] as? Double {
                            restaurantModel.deliveryCost = value
                        }
                        
                        if let value = sortingValues["minCost"] as? Double {
                            restaurantModel.minCost = value
                        }
                    }
                }
            }
        }
        saveContext()
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TakeAway")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.reset()
                let nserror = error as NSError
                print("Unresolved error : \(nserror.userInfo)")
            }
        }
    }

}

