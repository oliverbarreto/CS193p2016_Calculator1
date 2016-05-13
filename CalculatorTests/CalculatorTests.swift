//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by David Oliver Barreto Rodríguez on 13/5/16.
//  Copyright © 2016 Oliver Barreto. All rights reserved.
//

import XCTest
import Calculator

class CalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
  
  func testDescriptionDisplayOutput() {
    
    let brain = CalculatorBrain()
    
    // touching 7 + would show “7 + ...” (with 7 still in the display)
    brain.setOperand(7)
    brain.performOperation("+")
    
    XCTAssertEqual(brain.description, "7 + ")
    XCTAssertEqual(brain.result, 7.0)
    
    // 7 + 9 would show “7 + ...” (9 in the display)
    //brain.setOperand(9) Entered but not pushed
    
    XCTAssertEqual(brain.description, "7 + ")
    XCTAssertEqual(brain.result, 7.0)

    // 7 + 9 = would show “7 + 9 =” (16 in the display)
    brain.setOperand(9)
    brain.performOperation("=")
    
    XCTAssertEqual(brain.description, "7 + 9")
    XCTAssertEqual(brain.result, 16.0)
        
    // + 9 = √ would show “√(7 + 9) =” (4 in the display)
    brain.performOperation("√")
    
    XCTAssertEqual(brain.description, "²√(7 + 9)")
    XCTAssertEqual(brain.result, 4.0)
    
    // 7 + 9 √ would show “7 + √(9) ...” (3 in the display)
    brain.setOperand(7)
    brain.performOperation("+")
    brain.setOperand(9)
    brain.performOperation("√")
    
    XCTAssertEqual(brain.description, "7 + ²√(9)")
    XCTAssertEqual(brain.result, 3.0)
    
    // 7 + 9 √ = would show “7 + √(9) =“ (10 in the display)
    brain.performOperation("=")
    
    XCTAssertEqual(brain.description, "7 + ²√(9)")
    XCTAssertEqual(brain.result, 10.0)

    // 7 + 9 = + 6 + 3 = would show “7 + 9 + 6 + 3 =” (25 in the display)
    brain.setOperand(7)
    brain.performOperation("+")
    brain.setOperand(9)
    brain.performOperation("=")
    brain.performOperation("+")
    brain.setOperand(6)
    brain.performOperation("+")
    brain.setOperand(3)
    brain.performOperation("=")
    
    XCTAssertEqual(brain.description, "7 + 9 + 6 + 3")
    XCTAssertEqual(brain.result, 25.0)
  
    // 7 + 9 = √ 6 + 3 = would show “6 + 3 =” (9 in the display)
    brain.setOperand(7)
    brain.performOperation("+")
    brain.setOperand(9)
    brain.performOperation("=")
    brain.performOperation("√")
    brain.setOperand(6)
    brain.performOperation("+")
    brain.setOperand(3)
    brain.performOperation("=")
    
    XCTAssertEqual(brain.description, "6 + 3")
    XCTAssertEqual(brain.result, 9.0)
        
    // 5 + 6 = 7 3 would show “5 + 6 =” (73 in the display)
    brain.setOperand(5)
    brain.performOperation("+")
    brain.setOperand(6)
    brain.performOperation("=")
    
    // brain.setOperand(73) Entered but not Pushed!!!
    
    XCTAssertEqual(brain.description, "5 + 6")
    XCTAssertEqual(brain.result, 11.0)
    
    // 7 + = would show “7 + 7 =” (14 in the display)
    brain.setOperand(7)
    brain.performOperation("+")
    brain.performOperation("=")
    
    XCTAssertEqual(brain.description, "7 + 7")
    XCTAssertEqual(brain.result, 14.0)
    
    // 4 × π = would show “4 × π =“ (12.5663706143592 in the display)
    brain.setOperand(4)
    brain.performOperation("×")
    brain.performOperation("π")
    brain.performOperation("=")
    
    XCTAssertEqual(brain.description, "4 × π")
    XCTAssertEqual(Int(brain.result), Int(12.5663706143592))
    
    // 4 + 5 × 3 = would show “4 + 5 × 3 =” (27 in the display)
    brain.setOperand(4)
    brain.performOperation("+")
    brain.setOperand(5)
    brain.performOperation("×")
    brain.setOperand(3)
    brain.performOperation("=")
    
    XCTAssertEqual(brain.description, "4 + 5 × 3")
    XCTAssertEqual(brain.result, 27.0)

    // 4 + 5 × 3 = could also show “(4 + 5) × 3 =” if you prefer (27 in the display)
  }
    
}
