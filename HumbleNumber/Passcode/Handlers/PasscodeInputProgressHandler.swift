//
//  PasscodeInputProgressHandler.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import Combine
import Foundation

protocol PasscodeInputProgressHandler {
    func increaseProgress(onSuccess onSuccessCompletionBlock: () -> Void, onProgressMax onProgressMaxCompletionBlock: () -> Void)
    func decreaseProgress(onSuccess completionBlock: () -> Void)
    func clearProgress(onSuccess completionBlock: () -> Void)
    func maxProgressValue() -> Int
    func progressPublisher() -> Published<Int>.Publisher
}

class PasscodeInputProgressHandlerReal: PasscodeInputProgressHandler {
    private let maxProgress = 4
    
    @Published private var inputProgress: Int
    
    init() {
        inputProgress = 0
    }
    
    func increaseProgress(onSuccess onSuccessCompletionBlock: () -> Void, onProgressMax onProgressMaxCompletionBlock: () -> Void) {
        if inputProgress < maxProgress {
            inputProgress += 1
            onSuccessCompletionBlock()
            
            if inputProgress >= maxProgress {
                onProgressMaxCompletionBlock()
            }
        }
    }
    
    func decreaseProgress(onSuccess completionBlock: () -> Void) {
        if inputProgress > 0 {
            inputProgress -= 1
            completionBlock()
        }
    }
    
    func clearProgress(onSuccess completionBlock: () -> Void) {
        if inputProgress > 0 {
            inputProgress = 0
            completionBlock()
        }
    }
    
    func maxProgressValue() -> Int {
        return maxProgress
    }
    
    func progressPublisher() -> Published<Int>.Publisher {
        return $inputProgress
    }
}
