//
//  FruitViewModel.swift
//  AutoScout
//
//  Created by Haneef Habib on 9/22/17.
//  Copyright © 2017 AutoScout. All rights reserved.
//

import UIKit

class TARestaurantsViewModel : NSObject,TARestaurantCellFavouriteDelegate {
    
    var restaurantModels : [TARestaurant]?
    var sortedModels : [TARestaurant]?
    var filteredModels : [TARestaurant]?
    
    var selectedSortOption : SortOptions?
    var searchTerm = ""
    let dataManager = TARestaurantDataManager.shared
    
    func loadData(completion :@escaping (_ error : Error?) -> Void) {
        weak var weakSelf = self
        dataManager.loadDataWithCompletion { (restaurants, error) in
            if let strongSelf = weakSelf {
                strongSelf.restaurantModels = restaurants
                strongSelf.filteredModels = restaurants
                strongSelf.sortResults()
                DispatchQueue.main.async(execute: {
                    completion(error)
                })
            }
        }
    }
    
    func filterResults() {
        filteredModels = searchTerm.isEmpty ? restaurantModels :  restaurantModels!.filter{ $0.name?.lowercased().range(of: searchTerm.lowercased()) != nil }
        sortResults()
    }
    
    func sortResults() {
        sortWithValues()
        sortWithStatus()
        sortWithFavourite()
    }
    
    func sortWithValues() {
        if let sortOption = selectedSortOption {
            switch sortOption {
            case .bestMatch:
                filteredModels?.sort{return $0.bestMatch > $1.bestMatch}
                
            case .deliveryCost:
                filteredModels?.sort{return $0.deliveryCosts < $1.deliveryCosts}
                
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
    
    func searchTermUpdated(_ searchString : String) {
        searchTerm = searchString
        filterResults()
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
    
    func sortRestaurantsWithOption(_ option : SortOptions?) {
        selectedSortOption = option
        sortResults()
    }
    
    //MARK: TARestaurantCellFavouriteDelegate
    func restaurantCellPressedFavourite(_ isFavourite: Bool, atIndex index: Int) {
        let currentModel = filteredModels![index]
        currentModel.isFavourite = isFavourite
    }
        
}
