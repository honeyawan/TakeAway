//
//  TARestaurantDataManagerTests.swift
//  TakeAwayTests
//
//  Created by Haneef Habib on 9/27/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import XCTest
@testable import TakeAway

class TARestaurantDataManagerTests: XCTestCase {
    
    var manager : TARestaurantDataManager!
    override func setUp() {
        super.setUp()
        manager = TARestaurantDataManager()
    }
    
    func testRestaurantReadsLocalFile(){
        XCTAssertNotNil(manager.geRestaurantJsonDataFromlocalFile())
    }
    
    func testLoadsRestaurantList(){
        XCTAssertNotNil(manager.loadRestaurantList())
    }
    
}
