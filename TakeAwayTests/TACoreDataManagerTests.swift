//
//  TACoreDataManagerTests.swift
//  TakeAwayTests
//
//  Created by Haneef Habib on 9/27/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import XCTest

class TACoreDataManagerTests: XCTestCase {
    
    var viewModel : TACoreDataManager!

    override func setUp() {
        super.setUp()
        viewModel = TACoreDataManager.shared
    }
    
    func testPersistentContainerExists() {
        XCTAssertNotNil(viewModel.persistentContainer)
    }

    func testContextExists() {
        XCTAssertNotNil(viewModel.persistentContainer.viewContext)
    }
    
    func testPersistenCoordinatorExists(){
        XCTAssertNotNil(viewModel.persistentContainer.persistentStoreCoordinator)
    }
    
    func testManagedObjectModelExists(){
        XCTAssertNotNil(viewModel.persistentContainer.managedObjectModel)
    }
    
 

}
