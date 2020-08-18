//
//  PasscodeDataRequestResult.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

struct PasscodeDataRequestResult {
    let code: PasscodeDataRequestResult.Value
}

extension PasscodeDataRequestResult {
    enum RequestError: Error {
        case invalidData
        case networkError(error: NetworkError)
    }
    
    enum Value {
        case success
        case failure(error: RequestError)
    }
}
