//
//  KeypadView.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import SwiftUI

fileprivate let keypadButtonWidth: CGFloat = 70
fileprivate let keypadButtonHeight: CGFloat = 70
fileprivate let keypadButtonsSpacing: CGFloat = 32

struct KeypadView: View {
    private let buttons: [KeypadButton]
    
    init(buttons: [KeypadButton]) {
        self.buttons = buttons
    }
    
    var body: some View {
        VStack {
            HStack(spacing: keypadButtonsSpacing) {
                Spacer()
                
                buttons[0]
                    .frame(width: keypadButtonWidth, height: keypadButtonHeight)
                
                buttons[1]
                    .letters(Text("ABC"))
                    .frame(width: keypadButtonWidth, height: keypadButtonHeight)
                
                buttons[2]
                    .letters(Text("DEF"))
                    .frame(width: keypadButtonWidth, height: keypadButtonHeight)
                
                Spacer()
            }
            .padding(.bottom)
                                
            HStack(spacing: keypadButtonsSpacing) {
                Spacer()
                
                buttons[3]
                    .letters(Text("GHI"))
                    .frame(width: keypadButtonWidth, height: keypadButtonHeight)
                
                buttons[4]
                    .letters(Text("JKL"))
                    .frame(width: keypadButtonWidth, height: keypadButtonHeight)
                
                buttons[5]
                    .letters(Text("MNO"))
                    .frame(width: keypadButtonWidth, height: keypadButtonHeight)
                
                Spacer()
            }
            .padding(.bottom)
                                
            HStack(spacing: keypadButtonsSpacing) {
                Spacer()
                
                buttons[6]
                    .letters(Text("PQRS"))
                    .frame(width: keypadButtonWidth, height: keypadButtonHeight)
                buttons[7]
                    .letters(Text("TUV"))
                    .frame(width: keypadButtonWidth, height: keypadButtonHeight)
                buttons[8]
                    .letters(Text("WXYZ"))
                    .frame(width: keypadButtonWidth, height: keypadButtonHeight)
                
                Spacer()
            }
            .padding(.bottom)
            
            buttons[9]
                .frame(width: keypadButtonWidth, height: keypadButtonHeight)
        }
    }
}

struct KeypadView_Previews: PreviewProvider {
    static var previews: some View {
        KeypadView(buttons: [KeypadButton]())
    }
}
