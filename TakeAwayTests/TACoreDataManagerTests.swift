//
//  TACoreDataManagerTests.swift
//  TakeAwayTests
//
//  Created by Haneef Habib on 9/27/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import XCTest
@testable import TakeAway
class TACoreDataManagerTests: XCTestCase {
    
    var manager : TACoreDataManager!

    override func setUp() {
        super.setUp()
        manager = TACoreDataManager.shared
    }
    
    func testPersistentContainerExists() {
        XCTAssertNotNil(manager.persistentContainer)
    }

    func testContextExists() {
        XCTAssertNotNil(manager.persistentContainer.viewContext)
    }
    
    func testPersistenCoordinatorExists(){
        XCTAssertNotNil(manager.persistentContainer.persistentStoreCoordinator)
    }
    
    func testManagedObjectModelExists(){
        XCTAssertNotNil(manager.persistentContainer.managedObjectModel)
    }
    
 

}
