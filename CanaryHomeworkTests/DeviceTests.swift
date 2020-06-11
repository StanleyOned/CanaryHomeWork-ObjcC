//
//  DeviceParserTests.swift
//  CanaryHomeworkTests
//
//  Created by Stanley Delacruz on 6/10/20.
//  Copyright © 2020 Michael Schroeder. All rights reserved.
//

import XCTest

/// Test class for Device model
class DeviceTests: XCTestCase {
    
    var sut: [Device]!
    
    func testDevice_didGetDevicesSuccessfully() {
        // Then
        setupSUT(with: "device_success")
        
        // When
        XCTAssertNotNil(sut)
    }
    
    func testDevice_didNotGetDevicesSuccessfully() {
        // Then
        setupSUT(with: "device_unsuccess")
        
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
                sut.append(Device(from: dict, managedObjectContext: context))
            })
        }
    }
}

