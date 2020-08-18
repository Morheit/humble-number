//
//  PasscodeScreenView.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

//21, 24, 27 - foreground color
//44, 47, 50

import SwiftUI

struct PasscodeScreenView<Presenter: PasscodePresenter>: View {
    @ObservedObject private var presenter: Presenter
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
        
    var body: some View {
        ZStack {
            Color.dark.edgesIgnoringSafeArea(.all)
            
            VStack {
                presenter.makeInformationMessageLabel()
                presenter.makeProgressBar()
                presenter.makeKeypad()
                
                HStack {
                    Spacer()
                    presenter.makeCancelButton()

                    Spacer()
                    Spacer()

                    presenter.makeDeleteButton()
                    Spacer()
                }
                .padding(.top)
            }
        }.onAppear {
            self.presenter.loadPasscodeData()
        }
    }
}

struct PasscodeView_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeScreenView(presenter: PasscodePresenterReal(interactor: PasscodeInteractorReal(inputHandler: PasscodeInputHandlerReal(), inputProgressHandler: PasscodeInputProgressHandlerReal(), dataRepository: PasscodeDataRepositoryReal())))
    }
}
