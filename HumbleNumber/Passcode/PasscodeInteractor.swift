//
//  PasscodeInteractor.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import Foundation
import Combine

protocol PasscodeInteractor {
    func appendInput(with value: String)
    func removeLastInput()
    func clearInput()
    func loadPasscodeData(completion: @escaping ((PasscodeDataRequestResult) -> Void))
    func passcodeDataPublisher() -> Published<PasscodeData>.Publisher
    func passcodeInputProgressPublisher() -> Published<Int>.Publisher
    func passcodeDataLoadingFlagPublisher() -> Published<Bool>.Publisher
    func maxPasscodeInputProgressValue() -> Int
}

final class PasscodeInteractorReal: PasscodeInteractor {
    private let passcodeInputHandler: PasscodeInputHandler
    private let passcodeInputProgressHandler: PasscodeInputProgressHandler
    private let passcodeDataRepository: PasscodeDataRepository
    
    init(inputHandler: PasscodeInputHandler,
         inputProgressHandler: PasscodeInputProgressHandler,
         dataRepository: PasscodeDataRepository) {        
        self.passcodeDataRepository = dataRepository
        self.passcodeInputHandler = inputHandler
        self.passcodeInputProgressHandler = inputProgressHandler
    }
    
    func appendInput(with value: String) {
        passcodeInputProgressHandler.increaseProgress(onSuccess: {
            passcodeInputHandler.appendInput(with: value)
        }, onProgressMax: {            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let isPasscodeMatched = (self.passcodeInputHandler.currentInputValue() == self.passcodeDataRepository.data().code)
                
                self.passcodeInputProgressHandler.clearProgress(onSuccess: {})
                self.passcodeInputHandler.clearInput()
                
                if isPasscodeMatched {
                    self.passcodeDataRepository.loadPasscodeData(completion: {_ in })
                }
            }
        })
    }
    
    func removeLastInput() {
        passcodeInputProgressHandler.decreaseProgress {
            passcodeInputHandler.removeLastInput()
        }
    }
    
    func clearInput() {
        passcodeInputProgressHandler.clearProgress {
            passcodeInputHandler.clearInput()
        }
    }
    
    func loadPasscodeData(completion: @escaping ((PasscodeDataRequestResult) -> Void)) {
        passcodeDataRepository.loadPasscodeData(completion: completion)
    }
    
    func passcodeDataPublisher() -> Published<PasscodeData>.Publisher {
        return passcodeDataRepository.passcodeDataPublisher()
    }
    
    func passcodeInputProgressPublisher() -> Published<Int>.Publisher {
        return passcodeInputProgressHandler.progressPublisher()
    }
    
    func passcodeDataLoadingFlagPublisher() -> Published<Bool>.Publisher {
        return passcodeDataRepository.passcodeDataLoadingFlagPublisher()
    }
    
    func maxPasscodeInputProgressValue() -> Int {
        return passcodeInputProgressHandler.maxProgressValue()
    }
}
