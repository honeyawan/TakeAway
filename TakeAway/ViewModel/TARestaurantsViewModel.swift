//
//  TARestaurantsViewModel.swift
//  TakeAway
//
//  Created by Haneef Habib on 9/26/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import UIKit

class TARestaurantsViewModel : NSObject,TARestaurantCellFavouriteDelegate {
    
    /// Origional list of restaurants
    var restaurantModels : [RestaurantModel]?
    
    /// Filtered and Sorted List of restaruants
    var filteredModels : [RestaurantModel]?
    
    var selectedSortOption : SortOptions?
    var searchTerm = ""
    let dataManager = TARestaurantDataManager()
    
    override init() {
        super.init()
        loadRestaurantList()
    }
    
    func loadRestaurantList() {
        restaurantModels =  dataManager.loadRestaurantList()
        filteredModels = restaurantModels
        sortResults()
    }
    
 
    //MARK: Sorting Functionality
    
    func sortRestaurantsWithOption(_ option : SortOptions?) {
        selectedSortOption = option
        sortResults()
    }

    func sortResults() {
        
        sortWithValues()
        sortWithStatus()
        sortWithFavourite()
        
        
        
//        filteredModels = filteredModels!.sorted {
//
//            if $0.statusCode != $1.statusCode {
//                return ($0.statusCode < $1.statusCode)
//            }
//
//            if $0.distance != $1.distance {
//                return ($0.distance < $1.distance)
//            }
//return true
//        }

    }
    
    
    
    func sortWithValues() {
        
        
        filteredModels = filteredModels!.sorted {
            if $0.statusCode != $1.statusCode {
            return $0.statusCode < $1.statusCode
            }
            return $0.isFavourite
            
        }
        
        if let sortOption = selectedSortOption {
            switch sortOption {
            case .bestMatch:
                filteredModels?.sort{return $0.bestMatch > $1.bestMatch}
                
            case .deliveryCost:
                filteredModels?.sort{return $0.deliveryCost < $1.deliveryCost}
                
            case .averageRating:
                filteredModels?.sort{return $0.ratingAverage > $1.ratingAverage}
                
            case .distance:
                filteredModels?.sort{return $0.distance < $1.distance}
                
            case .minCost:
                filteredModels?.sort{return $0.minCost < $1.minCost}
                
            case .Newest:
                filteredModels?.sort{return $0.newest > $1.newest}
                
            case .productPrice:
                filteredModels?.sort{return $0.averageProductPrice < $1.averageProductPrice}
            }
        }
    }
    
    
    
   private func sortWithFavourite() {
        filteredModels?.sort{return ($0.isFavourite && !$1.isFavourite)}
    }
    
    private func sortWithStatus() {
        filteredModels?.sort{return ($0.statusCode < $1.statusCode)}
    }
    
    // Mark: Filter Functionality
    func searchTermUpdated(_ searchString : String) {
        searchTerm = searchString
        filterResults()
    }
    
    func filterResults() {
        filteredModels = searchTerm.isEmpty ? restaurantModels :  restaurantModels!.filter{ $0.name?.lowercased().range(of: searchTerm.lowercased()) != nil }
        sortResults()
    }
    
    
    
    func  numberOfRowsInSection() -> Int {
        if let restaurants = filteredModels {
            return restaurants.count
        }
        return 0
    }
    
    func configureCell(_ restaurantCell : TARestaurantTableViewCell , indexPath : IndexPath) {
        guard filteredModels != nil else {
            return
        }
        
        let currentmodel = filteredModels![indexPath.row]
        restaurantCell.lblName.text = currentmodel.name ?? ""
        restaurantCell.lblStatus.text = "Status : \((currentmodel.status ?? "").uppercased())\nDistance : \(textForDistance(currentmodel.distance))  MinCost:$\(currentmodel.minCost)"
        restaurantCell.index = indexPath.row
        restaurantCell.btnFavourite.isSelected = currentmodel.isFavourite
        restaurantCell.delegate = self

    }
    
    
    // We can also do this by creating extension of Double
    func textForDistance(_ meters : Double) -> String {
        return "\(String(format: "%.1f",meters/1000)) km"
    }
    
    //MARK: TARestaurantCellFavouriteDelegate
    func restaurantCellPressedFavourite(_ isFavourite: Bool, atIndex index: Int) {
        let currentModel = filteredModels![index]
        currentModel.isFavourite = isFavourite
        dataManager.saveResults()
    }
        
}
