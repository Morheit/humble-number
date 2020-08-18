//
//  DataLoadingIndicator.swift
//  HumbleNumber
//
//  Created by Yaroslav Stanislavyk on 19.08.2020.
//  Copyright © 2020 Yaroslav Stanislavyk. All rights reserved.
//

import SwiftUI

struct DataLoadingIndicator: UIViewRepresentable {
    private let isLoading: Bool
    private let style: UIActivityIndicatorView.Style
    private let color: UIColor
    
    init(isLoading: Bool, style: UIActivityIndicatorView.Style, color: UIColor = .white) {
        self.isLoading = isLoading
        self.style = style
        self.color = color
    }
    
    func makeUIView(context: UIViewRepresentableContext<DataLoadingIndicator>) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        activityIndicatorView.color = color
        return activityIndicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<DataLoadingIndicator>) {
        isLoading ? uiView.startAnimating() : uiView.stopAnimating()
    }
    
}
