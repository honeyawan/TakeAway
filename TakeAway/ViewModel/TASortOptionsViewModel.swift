//
//  TASortOptionsViewModel.swift
//  TakeAway
//
//  Created by Haneef Habib on 9/27/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import UIKit

public enum SortOptions:String {
    case bestMatch = "Best Match"
    case Newest = "Newest"
    case averageRating = "Average Rating"
    case distance = "Distance"
    case deliveryCost = "Delivery Cost"
    case productPrice = "Avg Product Price"
    case minCost = "Minimum Cost"
}

class TASortOptionsViewModel: NSObject {
    
    
//    weak var btnSort: UIButton?
//    weak var sortOptionHeight: NSLayoutConstraint?
//
//    func sortButtonPressed(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
    var selectedSortOption : SortOptions?
    var pickerContent : [SortOptions] = [SortOptions.bestMatch , SortOptions.Newest , SortOptions.averageRating , SortOptions.distance,SortOptions.deliveryCost, SortOptions.productPrice,SortOptions.minCost]
    
    
    func titleForSelectedSortOption()->String? {
        return selectedSortOption?.rawValue
    }
    
    func titleForPickerRow(_ row : Int) -> NSAttributedString {
        let string = pickerContent[row].rawValue
        return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
    }
    
    func numberOfRowsinPickerComponent(_ component : Int) -> Int {
        return pickerContent.count
    }
    
    func sortOptionSelected(_ row : Int) {
        selectedSortOption = pickerContent[row]
    }
    
}
