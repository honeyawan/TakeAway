//
//  SortOptionsViewModelTests.swift
//  TakeAwayTests
//
//  Created by Haneef Habib on 9/27/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import XCTest
@testable import TakeAway

class TASortOptionsViewModelTests: XCTestCase {
    
    var viewModel :  TASortOptionsViewModel!
    override func setUp() {
        super.setUp()
        viewModel = TASortOptionsViewModel()
    }
    

    func testSortOptionsAreNotEmpty() {
        XCTAssertTrue(viewModel.pickerContent.count > 0)
    }
    
    func testSortOptionsNumberOfRowsInPicker() {
        XCTAssertEqual(viewModel.pickerContent.count, viewModel.numberOfRowsinPickerComponent(0))
    }
    
    func testSortOptionNotNilAfterSelection() {
        viewModel.sortOptionSelected(1)
        XCTAssertNotNil(viewModel.selectedSortOption)
        XCTAssertEqual(viewModel.titleForSelectedSortOption(), viewModel.pickerContent[1].rawValue)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
