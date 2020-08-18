//
//  PasscodeInputHandler.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

protocol PasscodeInputHandler {
    func appendInput(with value: String)
    func removeLastInput()
    func clearInput()
    func currentInputValue() -> String
}

class PasscodeInputHandlerReal: PasscodeInputHandler {
    private var input: String
    
    init() {
        self.input = ""
    }
    
    func appendInput(with value: String) {
        input.append(value)
    }
    
    func removeLastInput() {
        input.removeLast()
    }
    
    func clearInput() {
        input.removeAll()
    }
    
    func currentInputValue() -> String {
        return input
    }
}
