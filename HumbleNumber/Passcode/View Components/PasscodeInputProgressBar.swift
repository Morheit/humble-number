//
//  PasscodeInputProgressBar.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import SwiftUI

fileprivate let progressIndicatorMaxWidth: CGFloat = 17
fileprivate let progressIndicatorMaxHeight: CGFloat = 17

struct PasscodeInputProgressBar: View {
    private let progressPoints: Range<Int>
    private let remainingProgressPoints: Range<Int>
    
    init(progressPoints: Range<Int>, remainingProgressPoints: Range<Int>) {
        self.progressPoints = progressPoints
        self.remainingProgressPoints = remainingProgressPoints
    }
    
    var body: some View {
        HStack(spacing: 25) {
            ForEach(progressPoints, id: \.self) { _ in
                Circle()
                .frame(maxWidth: progressIndicatorMaxWidth,
                       maxHeight: progressIndicatorMaxHeight)
            }
            ForEach(remainingProgressPoints, id: \.self) { _ in
                Circle()
                .stroke(Color.darkOrange, lineWidth: 1)
                .foregroundColor(.clear)
                .frame(maxWidth: progressIndicatorMaxWidth,
                maxHeight: progressIndicatorMaxHeight)
            }
        }
    }
}

struct PasscodeInputProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeInputProgressBar(progressPoints: 0..<3, remainingProgressPoints: 0..<4)
    }
}
