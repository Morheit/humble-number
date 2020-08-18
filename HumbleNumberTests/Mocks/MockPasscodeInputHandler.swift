//
//  MockPasscodeInputHandler.swift
//  HumbleNumberTests
//
//  Created by Yaroslav Stanislavyk on 20.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

@testable import HumbleNumber

class MockPasscodeInputHandler: Mock<MockPasscodeInputHandler.Actions>, PasscodeInputHandler {
    enum Actions {
        case appendInput
        case removeLastInput
        case clearInput
        case currentInputValue
    }
    
    func appendInput(with value: String) {
        registerCall(.appendInput)
    }
    
    func removeLastInput() {
        registerCall(.removeLastInput)
    }
    
    func clearInput() {
        registerCall(.clearInput)
    }
    
    func currentInputValue() -> String {
        registerCall(.currentInputValue)
        
        return returnValue[.currentInputValue] as? String ?? ""
    }
}
