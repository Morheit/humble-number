//
//  MockPasscodeInputProgressHandler.swift
//  HumbleNumberTests
//
//  Created by Yaroslav Stanislavyk on 20.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import Combine
@testable import HumbleNumber

class MockPasscodeInputProgressHandler: Mock<MockPasscodeInputProgressHandler.Actions>, PasscodeInputProgressHandler {
    @Published private var progress: Int = 0
    
    private var isIncreaseProgressOnSuccessCompletionActive = false
    private var isIncreaseProgressOnProgressMaxCompletionActive = false
    private var isDecreaseProgressOnSuccessCompletionActive = false
    private var isClearProgressOnSuccessCompletionActive = false
    
    enum Actions {
        case increaseProgress
        case decreaseProgress
        case clearProgress
        case maxProgressValue
        case progressPublisher
    }
    
    func useIncreaseProgressOnSuccessCompletion(_ isOn: Bool) {
        isIncreaseProgressOnSuccessCompletionActive = isOn
    }
    
    func useIncreaseProgressOnProgressMaxCompletion(_ isOn: Bool) {
        isIncreaseProgressOnProgressMaxCompletionActive = isOn
    }
    
    func useDecreaseProgressOnSuccessCompletion(_ isOn: Bool) {
        isDecreaseProgressOnSuccessCompletionActive = isOn
    }
    
    func useClearProgressOnSuccessCompletion(_ isOn: Bool) {
        isClearProgressOnSuccessCompletionActive = isOn
    }
    
    func increaseProgress(onSuccess onSuccessCompletionBlock: () -> Void, onProgressMax onProgressMaxCompletionBlock: () -> Void) {
        registerCall(.increaseProgress)
        
        if isIncreaseProgressOnSuccessCompletionActive {
            onSuccessCompletionBlock()
        }
        
        if isIncreaseProgressOnProgressMaxCompletionActive {
            onProgressMaxCompletionBlock()
        }
    }
    
    func decreaseProgress(onSuccess completionBlock: () -> Void) {
        registerCall(.decreaseProgress)
        
        if isDecreaseProgressOnSuccessCompletionActive {
            completionBlock()
        }
    }
    
    func clearProgress(onSuccess completionBlock: () -> Void) {
        registerCall(.clearProgress)
        
        if isClearProgressOnSuccessCompletionActive {
            completionBlock()
        }
    }
    
    func maxProgressValue() -> Int {
        registerCall(.maxProgressValue)
        
        return returnValue[.maxProgressValue] as? Int ?? -1
    }
    
    func progressPublisher() -> Published<Int>.Publisher {
        registerCall(.progressPublisher)
        
        return returnValue[.progressPublisher] as? Published<Int>.Publisher ?? $progress
    }
}
