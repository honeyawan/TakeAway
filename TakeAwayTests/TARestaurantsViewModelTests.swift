//
//  RestaurantsViewModelTests.swift
//  TakeAwayTests
//
//  Created by Haneef Habib on 9/27/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import XCTest
@testable import TakeAway

class TARestaurantsViewModelTests: XCTestCase {
    
    var viewModel :  TARestaurantsViewModel!
    override func setUp() {
        super.setUp()
        viewModel = TARestaurantsViewModel()
    }
    
    func testLoadData() {
        XCTAssertNotNil(viewModel.restaurantModels)
        XCTAssertNotNil(viewModel.filteredModels)
    }
    
   func testSortByRatings(){
    viewModel.sortRestaurantsWithOption(SortOptions.averageRating)
    XCTAssertGreaterThan(viewModel.filteredModels!.first!.ratingAverage, viewModel.filteredModels!.last!.ratingAverage)
    }
    
    
    func testSortByDistance(){
        viewModel.sortRestaurantsWithOption(SortOptions.distance)
         XCTAssertLessThan(viewModel.filteredModels!.first!.distance, viewModel.filteredModels!.last!.distance)
    }
    
    func testSortByMinCost(){
        viewModel.sortRestaurantsWithOption(SortOptions.minCost)
        XCTAssertLessThan(viewModel.filteredModels!.first!.minCost, viewModel.filteredModels!.last!.minCost)
    }
    
    func testSortByStatus(){
        // FilteredModels are default sorted by status
        XCTAssertLessThan(viewModel.filteredModels!.first!.statusCode, viewModel.filteredModels!.last!.statusCode)
    }
    
    func testFilterResults() {
        viewModel.searchTermUpdated("food")
        if let fitleredModels = viewModel.filteredModels {
            let randomIndex = Int(arc4random())%fitleredModels.count
            XCTAssert(fitleredModels[randomIndex].name!.contains("food"))
        }
    }
    
    
    func testConformsToTableViewDataSourceProtocol() {
        
        XCTAssert(viewModel.conforms(to: TARestaurantCellFavouriteDelegate.self))
        XCTAssert(viewModel.responds(to: #selector(viewModel.restaurantCellPressedFavourite(_:atIndex:))))
    }
    
    func testTextForDistance(){
     XCTAssertEqual(viewModel.textForDistance(1500), "1.5 km")
    }
    

    
}
