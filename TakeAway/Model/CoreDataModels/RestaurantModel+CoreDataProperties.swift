//
//  RestaurantModel+CoreDataProperties.swift
//  TakeAway
//
//  Created by Haneef Habib on 9/26/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//
//

import Foundation
import CoreData


extension RestaurantModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestaurantModel> {
        return NSFetchRequest<RestaurantModel>(entityName: "RestaurantModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var ratingAverage: Double
    @NSManaged public var bestMatch: Double
    @NSManaged public var newest: Double
    @NSManaged public var distance: Double
    @NSManaged public var minCost: Double
    @NSManaged public var status: String?
    @NSManaged public var popularity: Double
    @NSManaged public var averageProductPrice: Double
    @NSManaged public var deliveryCost: Double
    @NSManaged public var isFavourite: Bool
    @NSManaged public var statusCode: Int16

}
