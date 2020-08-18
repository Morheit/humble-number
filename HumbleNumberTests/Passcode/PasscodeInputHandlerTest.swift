//
//  PasscodeInputHandlerTest.swift
//  HumbleNumberTests
//
//  Created by Yaroslav Stanislavyk on 20.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import XCTest
@testable import HumbleNumber

class PasscodeInputHandlerTest: XCTestCase {
    private var passcodeInputHandler: PasscodeInputHandlerReal!
    
    private func loadInput() {
        passcodeInputHandler.appendInput(with: "1")
        passcodeInputHandler.appendInput(with: "2")
        passcodeInputHandler.appendInput(with: "3")
        passcodeInputHandler.appendInput(with: "4")
    }
    
    override func setUp() {
        passcodeInputHandler = PasscodeInputHandlerReal()
        
        XCTAssert(passcodeInputHandler.currentInputValue().isEmpty)
    }
    
    func testInputValueAdding() throws {
        loadInput()
        
        XCTAssertEqual(passcodeInputHandler.currentInputValue(), "1234")
    }
    
    func testLastInputRemoving() throws {
        loadInput()
        passcodeInputHandler.removeLastInput()
        
        XCTAssertEqual(passcodeInputHandler.currentInputValue(), "123")
    }
    
    func testInputClearing() throws {
        loadInput()
        passcodeInputHandler.clearInput()
        
        XCTAssert(passcodeInputHandler.currentInputValue().isEmpty)
    }
}
