//
//  MockPasscodeDataRepository.swift
//  HumbleNumberTests
//
//  Created by Yaroslav Stanislavyk on 20.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import Combine
@testable import HumbleNumber

class MockPasscodeDataRepository: Mock<MockPasscodeDataRepository.Actions>, PasscodeDataRepository {
    @Published private var passcodeData = PasscodeData()
    @Published private var isDataLoading = true
    
    enum Actions {
        case data
        case loadPasscodeData
        case passcodeDataPublisher
        case passcodeDataLoadingFlagPublisher
    }
    
    func data() -> PasscodeData {
        registerCall(.data)
        
        return returnValue[.data] as? PasscodeData ?? PasscodeData()
    }
    
    func loadPasscodeData(completion: @escaping ((PasscodeDataRequestResult) -> Void)) {
        registerCall(.loadPasscodeData)
    }
    
    func passcodeDataPublisher() -> Published<PasscodeData>.Publisher {
        registerCall(.passcodeDataPublisher)
        
        return returnValue[.passcodeDataPublisher] as? Published<PasscodeData>.Publisher ?? $passcodeData
    }
    
    func passcodeDataLoadingFlagPublisher() -> Published<Bool>.Publisher {
        registerCall(.passcodeDataLoadingFlagPublisher)
        
        return returnValue[.passcodeDataLoadingFlagPublisher] as? Published<Bool>.Publisher ?? $isDataLoading
    }
}
