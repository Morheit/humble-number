//
//  ContentView.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 18.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        passcodeScreenView()
    }
    
    private func passcodeScreenView() -> some View {
        let passcodeInputHandler = PasscodeInputHandlerReal()
        let passcodeInputProgressHandler = PasscodeInputProgressHandlerReal()
        let passcodeDataRepository = PasscodeDataRepositoryReal()
        let passcodeInteractor = PasscodeInteractorReal(inputHandler: passcodeInputHandler,
                                                        inputProgressHandler: passcodeInputProgressHandler,
                                                        dataRepository: passcodeDataRepository)
        let passcodePresenter = PasscodePresenterReal(interactor: passcodeInteractor)
        return AnyView(PasscodeScreenView(presenter: passcodePresenter))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
