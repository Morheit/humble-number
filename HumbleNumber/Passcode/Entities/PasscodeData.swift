//
//  PasscodeData.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

struct PasscodeData {
    let digits: [Int]
    let code: String
    
    init(digits: [Int], code: String) {
        self.digits = digits
        self.code = code
    }
    
    init() {
        self.digits = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
        self.code = "1234"
    }
}

extension PasscodeData {
    static func from(data: [String: Any]) -> PasscodeData? {
        guard let setupValue = data["setup"], let passcode = data["code"] else {
            return nil
        }
                
        switch (setupValue, passcode) {
        case let (passcodeDigits, passcode) as ([Int], String):
            return PasscodeData(digits: passcodeDigits, code: passcode)
        default:
            return nil
        }
    }
}
