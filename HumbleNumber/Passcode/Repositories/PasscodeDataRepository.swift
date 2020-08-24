//
//  PasscodeDataRepository.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import Foundation

// NOTE: For mock testing purposes only. The credentials should never be hard coded in the code
fileprivate let serverUsername = "Runloop"
fileprivate let serverPassword = "Run!@0p"
fileprivate let serverUsernameParameter = "username"
fileprivate let serverPasswordParameter = "password"
fileprivate let apiEndpoint = "getPasscodeInternals"


protocol PasscodeDataRepository {
    func data() -> PasscodeData
    func loadPasscodeData(completion: @escaping ((PasscodeDataRequestResult) -> Void))
    func passcodeDataPublisher() -> Published<PasscodeData>.Publisher
    func passcodeDataLoadingFlagPublisher() -> Published<Bool>.Publisher
}

class PasscodeDataRepositoryReal: PasscodeDataRepository {
    @Published private var passcodeData: PasscodeData
    @Published private var isPasscodeDataLoading: Bool
    
    init() {
        self.passcodeData = PasscodeData()
        self.isPasscodeDataLoading = true
    }
    
    func data() -> PasscodeData {
        return passcodeData
    }
    
    func loadPasscodeData(completion: @escaping ((PasscodeDataRequestResult) -> Void)) {
        isPasscodeDataLoading = true
        
        DispatchQueue.global(qos: .background).async {
            try? HumbleMockServer.sendApiCall(endpoint: apiEndpoint,
                                              params: [serverUsernameParameter : serverUsername,
                                                       serverPasswordParameter : serverPassword],
                                              completion: { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                                                
                defer {
                    strongSelf.isPasscodeDataLoading = false
                }
                                                
                switch result.code {
                case .success:
                    guard let data = result.value else {
                        completion(PasscodeDataRequestResult(code: .failure(error: .invalidData)))
                        return
                    }
                    
                    strongSelf.passcodeData = PasscodeData.from(data: data)!
                    completion(PasscodeDataRequestResult(code: .success))
                case .failure(error: let error):
                    completion(PasscodeDataRequestResult(code: .failure(error: .networkError(error: error))))
                }
            })
        }        
    }
    
    func passcodeDataPublisher() -> Published<PasscodeData>.Publisher {
        return $passcodeData
    }
    
    func passcodeDataLoadingFlagPublisher() -> Published<Bool>.Publisher {
        return $isPasscodeDataLoading
    }
}
