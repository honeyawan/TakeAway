//
//  ViewControllerTests.swift
//  TakeAwayTests
//
//  Created by Haneef Habib on 9/27/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import XCTest
@testable import TakeAway

class ViewControllerTests: XCTestCase {
        
    var restaurantsViewController: ViewController!
    
    override func setUp() {
        
        super.setUp()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        restaurantsViewController = storyboard.instantiateViewController(withIdentifier: "RestaurantViewController") as! ViewController
        _ = restaurantsViewController.view
    }
    
    
    func testIBOutlestsAreNotNilAfterViewDidLoad() {
        
        XCTAssertNotNil(restaurantsViewController.tableView)
        XCTAssertNotNil(restaurantsViewController.btnSort)
        XCTAssertNotNil(restaurantsViewController.spinner)
        XCTAssertNotNil(restaurantsViewController.sortOptionHeight)
        
    }
    
    func testShouldSetTableViewDataSource() {
        XCTAssertNotNil(restaurantsViewController.tableView.dataSource)
    }
    
    func testConformsToTableViewDataSourceProtocol() {
        
        
        XCTAssert(restaurantsViewController.conforms(to: UITableViewDelegate.self))
        XCTAssert(restaurantsViewController.responds(to: #selector(restaurantsViewController.tableView(_:numberOfRowsInSection:))))
        
        XCTAssert(restaurantsViewController.conforms(to: UITableViewDataSource.self))
        
        XCTAssert(restaurantsViewController.responds(to: #selector(restaurantsViewController.tableView(_:numberOfRowsInSection:))))
        
        XCTAssert(restaurantsViewController.responds(to: #selector(restaurantsViewController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewUsesCustomCell_TARestaurantTableViewCell() {
        
        let firstCell = restaurantsViewController.tableView(restaurantsViewController.tableView, cellForRowAt: IndexPath.init(row: 0, section: 0))
        
        XCTAssert(firstCell is TARestaurantTableViewCell)
    }
    
    func testConformsToSearchBarDelegate() {
        XCTAssert(restaurantsViewController.conforms(to: UISearchBarDelegate.self))
        
        XCTAssert(restaurantsViewController.responds(to: #selector(restaurantsViewController.searchBar(_:textDidChange:))))
        
        XCTAssert(restaurantsViewController.responds(to: #selector(restaurantsViewController.searchBarSearchButtonClicked(_:))))
    }
    
    
    func testConformsToPickerViewDataSource() {
        XCTAssert(restaurantsViewController.conforms(to: UIPickerViewDataSource.self))
        
        XCTAssert(restaurantsViewController.responds(to: #selector(restaurantsViewController.numberOfComponents(in:))))
        
        XCTAssert(restaurantsViewController.responds(to: #selector(restaurantsViewController.pickerView(_:numberOfRowsInComponent:))))
        
        XCTAssert(restaurantsViewController.responds(to: #selector(restaurantsViewController.pickerView(_:attributedTitleForRow:forComponent:))))
        
    }
    
    func testConformsToPickerViewDelegate() {
        
        XCTAssert(restaurantsViewController.conforms(to: UIPickerViewDelegate.self))
        XCTAssert(restaurantsViewController.responds(to: #selector(restaurantsViewController.pickerView(_:didSelectRow:inComponent:))))
    }
    
}
