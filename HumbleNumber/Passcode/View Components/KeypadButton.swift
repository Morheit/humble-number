//
//  KeypadButton.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import SwiftUI

struct KeypadButton: View {
    private let action: () -> Void
    private let number: Text
    private let letters: Text
    
    @State private var isPressed: Bool
    
    init(action: @escaping () -> Void,
         number: Text,
         letters: Text = Text(""),
         isPressed: Bool = false) {
        self.number = number
        self.letters = letters
        self.action = action
        self._isPressed = State<Bool>(initialValue: isPressed)
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .foregroundColor(isPressed ? .gray : .darkGray)
                VStack(alignment: .center) {
                    number
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        
                    letters
                        .foregroundColor(.white)
                        .font(.footnote)
                        .fontWeight(.light)
                        .tracking(1)
                        .multilineTextAlignment(.center)
                        .offset(y: -4)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0.0)
                .onChanged({ _ in
                    if !self.isPressed {
                        self.isPressed = true
                    }
                })
                .onEnded({ _ in
                    self.isPressed = false
                })
        )
    }
    
    func letters(_ text: Text) -> KeypadButton {
        return KeypadButton(action: action, number: number, letters: text, isPressed: isPressed)
    }
}

struct KeypadButton_Previews: PreviewProvider {
    static var previews: some View {
        KeypadButton(action: {}, number: Text("0"))
    }
}
