//
//  MockPasscodePresenter.swift
//  HumbleNumberTests
//
//  Created by Yaroslav Stanislavyk on 20.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import SwiftUI
@testable import HumbleNumber

class MockPasscodePresenter: Mock<MockPasscodePresenter.Actions>, PasscodePresenter {
    enum Actions {
        case loadPasscodeData
        case makeProgressBar
        case makeInformationMessageLabel
        case makeKeypad
        case makeCancelButton
        case makeDeleteButton
    }
    
    func loadPasscodeData() {
        registerCall(.loadPasscodeData)
    }
    
    func makeProgressBar() -> AnyView {
        registerCall(.makeProgressBar)
        
        return returnValue[.makeProgressBar] as? AnyView ?? AnyView(Text(""))
    }
    
    func makeInformationMessageLabel() -> AnyView {
        registerCall(.makeInformationMessageLabel)
        
        return returnValue[.makeInformationMessageLabel] as? AnyView ?? AnyView(Text(""))
    }
    
    func makeKeypad() -> AnyView {
        registerCall(.makeKeypad)
        
        return returnValue[.makeKeypad] as? AnyView ?? AnyView(Text(""))
    }
    
    func makeCancelButton() -> AnyView {
        registerCall(.makeCancelButton)
        
        return returnValue[.makeCancelButton] as? AnyView ?? AnyView(Text(""))
    }
    
    func makeDeleteButton() -> AnyView {
        registerCall(.makeDeleteButton)
        
        return returnValue[.makeDeleteButton] as? AnyView ?? AnyView(Text(""))
    }
}
