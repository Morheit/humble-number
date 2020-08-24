//
//  PasscodePresenter.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import SwiftUI
import Combine
import os

protocol PasscodePresenter: ObservableObject {
    func loadPasscodeData()
    func makeProgressBar() -> AnyView
    func makeInformationMessageLabel() -> AnyView
    func makeKeypad() -> AnyView
    func makeCancelButton() -> AnyView
    func makeDeleteButton() -> AnyView
}

final class PasscodePresenterReal: PasscodePresenter {
    private let interactor: PasscodeInteractor
    
    private let logger = OSLog.init(subsystem: Bundle.main.bundleIdentifier!, category: "Passcode")
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private var passcodeData: PasscodeData
    @Published private var informationLabelText: String
    @Published private var passcodeInputProgress: Int
    @Published private var isPasscodeDataLoading: Bool
    
    init(interactor: PasscodeInteractor) {
        self.passcodeData = PasscodeData()
        self.informationLabelText = ""
        self.passcodeInputProgress = 0
        self.isPasscodeDataLoading = true
        
        self.interactor = interactor
        
        self.interactor.passcodeDataPublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: \.passcodeData, on: self)
            .store(in: &cancellables)
        
        self.interactor.passcodeInputProgressPublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: \.passcodeInputProgress, on: self)
            .store(in: &cancellables)
        
        self.interactor.passcodeDataLoadingFlagPublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isPasscodeDataLoading, on: self)
            .store(in: &cancellables)
        
    }
    
    func loadPasscodeData() {
        interactor.loadPasscodeData(completion: { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result.code {
            case .success:
                DispatchQueue.main.async {
                    strongSelf.informationLabelText = "Please enter your 4 digit pin code:"
                }
            case .failure(error: let error):
                DispatchQueue.main.async {
                    strongSelf.informationLabelText = "Oops. Something went wrong. Please try again later"
                }
                
                os_log("An error during the passcode data loading: %@", log: strongSelf.logger, type: .error, error.localizedDescription)
            }
        })
    }
    
    func makeProgressBar() -> AnyView {
        if isPasscodeDataLoading {
            return AnyView(
                DataLoadingIndicator(isLoading: isPasscodeDataLoading,
                                     style: .large)
                    .padding(.vertical)
            )
        } else {
            let maxProgressValue = interactor.maxPasscodeInputProgressValue()
            let progressPoints = ((maxProgressValue - passcodeInputProgress)..<maxProgressValue)
            let remainingProgressPoints = (passcodeInputProgress..<maxProgressValue)
            
            return AnyView(
                PasscodeInputProgressBar(progressPoints: progressPoints, remainingProgressPoints: remainingProgressPoints)
                    .foregroundColor(.darkOrange)
                    .padding(.top)
                    .padding(.bottom, 40)
            )
        }
    }
    
    func makeInformationMessageLabel() -> AnyView {
        if isPasscodeDataLoading {
            return AnyView(
                Text("The passcode data is loading. Please wait")
                    .foregroundColor(.darkOrange)
            )
        }
        
        return AnyView(
            Text(informationLabelText)
                .foregroundColor(.darkOrange)
        )
    }
    
    func makeKeypad() -> AnyView {        
        var keypadButtons = [KeypadButton]()
        
        for digit in passcodeData.digits {
            let stringDigit = String(digit)
            let keypadButton = KeypadButton(action: {
                self.interactor.appendInput(with: stringDigit)
            }, number: Text(stringDigit))
            
            keypadButtons.append(keypadButton)
        }
        
        return AnyView(
            KeypadView(buttons: keypadButtons)
                .disabled(isPasscodeDataLoading)
        )
    }
    
    func makeCancelButton() -> AnyView {
        return AnyView(
            Button(action: {
                self.interactor.clearInput()
            }) {
                Text("Cancel")
                    .foregroundColor(.white)
            }
            .disabled(isPasscodeDataLoading)
        )
    }
    
    func makeDeleteButton() -> AnyView {
        return AnyView(
            Button(action: {
                self.interactor.removeLastInput()
            }) {
                Text("Delete")
                    .foregroundColor(.white)
            }
            .disabled(isPasscodeDataLoading)
        )
    }
}
