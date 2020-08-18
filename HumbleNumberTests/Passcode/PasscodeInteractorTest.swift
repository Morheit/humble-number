//
//  PasscodeInteractorTest.swift
//  HumbleNumberTests
//
//  Created by Yaroslav Stanislavyk on 20.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import XCTest
@testable import HumbleNumber

class PasscodeInteractorTest: XCTestCase {
    private var mockPasscodeInputHandler: MockPasscodeInputHandler!
    private var mockPasscodeInputProgressHandler: MockPasscodeInputProgressHandler!
    private var mockPasscodeDataRepository: MockPasscodeDataRepository!
    
    private var passcodeInteractor: PasscodeInteractorReal!
    
    override func setUp() {
        mockPasscodeInputHandler = MockPasscodeInputHandler()
        mockPasscodeInputProgressHandler = MockPasscodeInputProgressHandler()
        mockPasscodeDataRepository = MockPasscodeDataRepository()
        
        passcodeInteractor = PasscodeInteractorReal(inputHandler: mockPasscodeInputHandler, inputProgressHandler: mockPasscodeInputProgressHandler, dataRepository: mockPasscodeDataRepository)
    }
    
    override func tearDown() {
        mockPasscodeInputHandler.verifyCalls()
        mockPasscodeInputProgressHandler.verifyCalls()
        mockPasscodeDataRepository.verifyCalls()
    }
    
    func testInputValuesAdding() throws {
        mockPasscodeInputHandler.expectCall(.appendInput)
        mockPasscodeInputProgressHandler.useIncreaseProgressOnSuccessCompletion(true)
        mockPasscodeInputProgressHandler.expectCall(.increaseProgress)
        
        passcodeInteractor.appendInput(with: "1")
    }
    
    func testLastInputRemoving() throws {
        mockPasscodeInputHandler.expectCall(.removeLastInput)
        mockPasscodeInputProgressHandler.expectCall(.decreaseProgress)
        mockPasscodeInputProgressHandler.useDecreaseProgressOnSuccessCompletion(true)
        
        passcodeInteractor.removeLastInput()
    }
    
    func testInputClearing() throws {
        mockPasscodeInputHandler.expectCall(.clearInput)
        mockPasscodeInputProgressHandler.expectCall(.clearProgress)
        mockPasscodeInputProgressHandler.useClearProgressOnSuccessCompletion(true)
        
        passcodeInteractor.clearInput()
    }
    
    func testPasscodeDataLoading() throws {
        mockPasscodeDataRepository.expectCall(.loadPasscodeData)
        
        passcodeInteractor.loadPasscodeData(completion: {_ in })
    }    
}
