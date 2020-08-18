//
//  HumbleMockServer.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case unknownEndpoint
    case unknownError
    case unknownParams
}

enum NetworkResult {
    case success
    case failure(error: NetworkError)
}

struct Result {
    let code: NetworkResult
    let value: [String : Any]?
}

final class HumbleMockServer {
    private struct Consts {
        static let passcodeDigits = 0...9
        static let possibleCodes = ["1234", "4321"]
    }

    private init() {}

    static func sendApiCall(endpoint: String, params: [String : String], completion: @escaping ((Result) -> Void)) throws {
        guard !endpoint.isEmpty && endpoint == "getPasscodeInternals" else {
            delayExecution {
                completion(Result(code: .failure(error: .unknownEndpoint), value: nil))
            }
            return
        }

        guard let username = params["username"], let password = params["password"] else {
            delayExecution {
                completion(Result(code: .failure(error: .unknownParams), value: nil))
            }
            return
        }

        let result: Result
        if username == "Runloop" && password == "Run!@0p" {
            let value: [String : Any] = ["setup": Consts.passcodeDigits.shuffled(),
                                         "code": Consts.possibleCodes.randomElement()!]
            result = Result(code: .success, value: value)
        } else {
            result = Result(code: .failure(error: .unknownError), value: nil)
        }

        delayExecution {
            completion(result)
        }
    }

    private static func delayExecution(completion: @escaping (() -> Void)) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3.0) {
            completion()
        }
    }
}

