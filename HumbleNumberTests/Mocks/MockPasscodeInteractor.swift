//
//  MockPasscodeInteractor.swift
//  HumbleNumberTests
//
//  Created by Yaroslav Stanislavyk on 20.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import Combine
@testable import HumbleNumber

class MockPasscodeInteractor: Mock<MockPasscodeInteractor.Actions>, PasscodeInteractor {
    @Published private var passcodeData = PasscodeData()
    @Published private var passcodeInputProgress = 0
    @Published private var isDataLoading = true
    
    enum Actions {
        case appendInput
        case removeLastInput
        case clearInput
        case loadPasscodeData
        case passcodeDataPublisher
        case passcodeInputProgressPublisher
        case passcodeDataLoadingFlagPublisher
        case maxPasscodeInputProgressValue
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
    
    func loadPasscodeData(completion: @escaping ((PasscodeDataRequestResult) -> Void)) {
        registerCall(.loadPasscodeData)
    }
    
    func passcodeDataPublisher() -> Published<PasscodeData>.Publisher {
        registerCall(.passcodeDataPublisher)
        
        return returnValue[.passcodeDataPublisher] as? Published<PasscodeData>.Publisher ?? $passcodeData
    }
    
    func passcodeInputProgressPublisher() -> Published<Int>.Publisher {
        registerCall(.passcodeInputProgressPublisher)
        
        return returnValue[.passcodeInputProgressPublisher] as? Published<Int>.Publisher ?? $passcodeInputProgress
    }
    
    func passcodeDataLoadingFlagPublisher() -> Published<Bool>.Publisher {
        registerCall(.passcodeDataLoadingFlagPublisher)
        
        return returnValue[.passcodeDataLoadingFlagPublisher] as? Published<Bool>.Publisher ?? $isDataLoading
    }
    
    func maxPasscodeInputProgressValue() -> Int {
        registerCall(.maxPasscodeInputProgressValue)
        
        return returnValue[.maxPasscodeInputProgressValue] as? Int ?? -1
    }
    
    
}
