//
//  TodoTests.swift
//  todoAppTests
//
//  Created by Raul Serrano on 11/4/18.
//  Copyright © 2018 Raul Serrano. All rights reserved.
//

import XCTest
@testable import todoApp

class TodoTests: XCTestCase {
  
    var task: TodoViewController!
    
    override func setUp() {
        super.setUp()
        task = TodoViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        task = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
