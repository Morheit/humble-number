//
//  PasscodeInputProgressHandlerTest.swift
//  HumbleNumberTests
//
//  Created by Yaroslav Stanislavyk on 20.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import Combine
import XCTest
@testable import HumbleNumber

class PasscodeInputProgressHandlerTest: XCTestCase {
    private var passcodeInputProgressHandler: PasscodeInputProgressHandlerReal!
    
    @Published private var passcodeProgress: Int = 0
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        passcodeInputProgressHandler = PasscodeInputProgressHandlerReal()
        
        passcodeInputProgressHandler.progressPublisher()
            .assign(to: \.passcodeProgress, on: self)
            .store(in: &cancellables)
    }
    
    func testProgressIncrease() throws {
        var isIncreaseProgressOnSuccessCallbackCalled = false
        
        passcodeInputProgressHandler.increaseProgress(onSuccess: {
            isIncreaseProgressOnSuccessCallbackCalled = true
        }, onProgressMax: {
            XCTFail("An incorrect progress value. The progress shouldn't be maxed out")
        })
        
        XCTAssertEqual(passcodeProgress, 1)
        XCTAssertTrue(isIncreaseProgressOnSuccessCallbackCalled)
        
        isIncreaseProgressOnSuccessCallbackCalled = false
        
        passcodeInputProgressHandler.increaseProgress(onSuccess: {
            isIncreaseProgressOnSuccessCallbackCalled = true
        }, onProgressMax: {
            XCTFail("An incorrect progress value. The progress shouldn't be maxed out")
        })
        
        XCTAssertEqual(passcodeProgress, 2)
        XCTAssertTrue(isIncreaseProgressOnSuccessCallbackCalled)
        
        isIncreaseProgressOnSuccessCallbackCalled = false
        
        passcodeInputProgressHandler.increaseProgress(onSuccess: {
            isIncreaseProgressOnSuccessCallbackCalled = true
        }, onProgressMax: {
            XCTFail("An incorrect progress value. The progress shouldn't be maxed out")
        })
        
        XCTAssertEqual(passcodeProgress, 3)
        XCTAssertTrue(isIncreaseProgressOnSuccessCallbackCalled)
        
        isIncreaseProgressOnSuccessCallbackCalled = false
        var isIncreaseProgressOnProgressMaxCallbackCalled = false
        
        passcodeInputProgressHandler.increaseProgress(onSuccess: {
            isIncreaseProgressOnSuccessCallbackCalled = true
        }, onProgressMax: {
            isIncreaseProgressOnProgressMaxCallbackCalled = true
        })
        
        XCTAssertEqual(passcodeProgress, 4)
        XCTAssertTrue(isIncreaseProgressOnSuccessCallbackCalled)
        XCTAssertTrue(isIncreaseProgressOnProgressMaxCallbackCalled)
        
        isIncreaseProgressOnSuccessCallbackCalled = false
        isIncreaseProgressOnProgressMaxCallbackCalled = false
        
        passcodeInputProgressHandler.increaseProgress(onSuccess: {
            isIncreaseProgressOnSuccessCallbackCalled = true
        }, onProgressMax: {
            isIncreaseProgressOnProgressMaxCallbackCalled = true
        })
        
        XCTAssertEqual(passcodeProgress, 4)
        XCTAssertFalse(isIncreaseProgressOnSuccessCallbackCalled)
        XCTAssertFalse(isIncreaseProgressOnProgressMaxCallbackCalled)
    }
    
    func testProgressDecrease() throws {
        passcodeInputProgressHandler.increaseProgress(onSuccess: {}, onProgressMax: {})
        passcodeInputProgressHandler.increaseProgress(onSuccess: {}, onProgressMax: {})
        passcodeInputProgressHandler.decreaseProgress(onSuccess: {})
        
        XCTAssertEqual(passcodeProgress, 1)
        
        passcodeInputProgressHandler.decreaseProgress(onSuccess: {})
        
        XCTAssertEqual(passcodeProgress, 0)
        
        passcodeInputProgressHandler.decreaseProgress(onSuccess: {})
        
        XCTAssertEqual(passcodeProgress, 0)
    }
    
    func testProgressClearing() throws {
        passcodeInputProgressHandler.increaseProgress(onSuccess: {}, onProgressMax: {})
        passcodeInputProgressHandler.increaseProgress(onSuccess: {}, onProgressMax: {})
        passcodeInputProgressHandler.increaseProgress(onSuccess: {}, onProgressMax: {})
        
        passcodeInputProgressHandler.clearProgress(onSuccess: {})
        
        XCTAssertEqual(passcodeProgress, 0)
    }
}
