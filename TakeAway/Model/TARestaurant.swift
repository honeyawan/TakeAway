

import UIKit

class TARestaurant {
    
    var name : String?
    var status : String?
    var statusCode = -1
    var bestMatch : Double = 0.0
    var newest : Double = 0.0
    var ratingAverage : Double = 0.0
    var distance : Double = 0.0
    var averageProductPrice : Double = 0.0
    var deliveryCosts : Double = 0.0
    var minCost : Double = 0.0
    var isFavourite = false

    init(dictionary : [String : Any]) {
        
        if let restaurantName = dictionary["name"] as?  String {
            name = restaurantName
        }
        
        if let restStatus = dictionary["status"] as? String {
            status = restStatus
            switch restStatus {
            case "open":
                statusCode = 1
            case "order ahead":
                statusCode = 2
            default:
                statusCode = 3
            }
        }
        
        if let sortingValues = dictionary["sortingValues"] as? [String : Any]{
            
            if let value = sortingValues["bestMatch"] as? Double {
                bestMatch = value
            }
            
            if let value = sortingValues["newest"] as? Double {
                newest = value
            }
            
            
            if let value = sortingValues["ratingAverage"] as? Double {
                ratingAverage = value
            }
            
            if let value = sortingValues["distance"] as? Double {
                distance = value
            }
            
            if let value = sortingValues["averageProductPrice"] as? Double {
                averageProductPrice = value
            }
            
            if let value = sortingValues["deliveryCosts"] as? Double {
                deliveryCosts = value
            }
            
            if let value = sortingValues["minCost"] as? Double {
                minCost = value
            }
        }        
    }
}


struct TARestaurantStuct {
    
    let name : String?
    let status : String?
    let bestMatch : Double = 0.0
    let newest : Double = 0.0
    let ratingAverage : Double = 0.0
    let distance : Double = 0.0
    let averageProductPrice : Double = 0.0
    let deliveryCosts : Double = 0.0
    let minCost : Double = 0.0
    
}
