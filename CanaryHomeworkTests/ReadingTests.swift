//
//  ReadingParserTests.swift
//  CanaryHomeworkTests
//
//  Created by Stanley Delacruz on 6/10/20.
//  Copyright © 2020 Michael Schroeder. All rights reserved.
//

import XCTest

/// Test class for Reading model
class ReadingTests: XCTestCase {
    
    var sut: [Reading]!
    
    func testReading_didGetDevicesSuccessfully() {
        // Then
        setupSUT(with: "reading_success")
        
        // When
        XCTAssertNotNil(sut)
    }
    
    func testReading_didNotGetDevicesSuccessfully() {
        // Then
        setupSUT(with: "reading_unsuccess")
        
        // When
        /// Device ID is required for Device model object.
        XCTAssertNil(sut.first?.deviceID)
    }
    
    private func setupSUT(with resource: String) {
        if let path = Bundle(for: type(of: self)).path(forResource: resource, ofType: "json") {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            guard let context = CoreDataManager.default()?.managedObjectContext else {
                return
            }
            let response = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [[AnyHashable: Any]]
            sut = []
            response?.forEach({ dict in
                sut.append(Reading(from: dict, managedObjectContext: context))
            })
        }
    }
}
