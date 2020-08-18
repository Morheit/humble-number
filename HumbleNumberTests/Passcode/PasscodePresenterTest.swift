//
//  PasscodePresenterTest.swift
//  HumbleNumberTests
//
//  Created by Yaroslav Stanislavyk on 20.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import SwiftUI
import XCTest
@testable import HumbleNumber

class PasscodePresenterTest: XCTestCase {
    private var mockPasscodeInteractor: MockPasscodeInteractor!
    private var passcodePresenter: PasscodePresenterReal!
    
    override func setUp() {
        mockPasscodeInteractor = MockPasscodeInteractor()
        mockPasscodeInteractor.expectCall(.passcodeDataPublisher)
        mockPasscodeInteractor.expectCall(.passcodeInputProgressPublisher)
        mockPasscodeInteractor.expectCall(.passcodeDataLoadingFlagPublisher)
        
        passcodePresenter = PasscodePresenterReal(interactor: mockPasscodeInteractor)        
    }
    
    override func tearDown() {
        mockPasscodeInteractor.verifyCalls()
    }
    
    func testLoadPasscodeData() throws {
        mockPasscodeInteractor.expectCall(.loadPasscodeData)
        
        passcodePresenter.loadPasscodeData()
    }
}
