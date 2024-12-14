//
//  view.swift
//  githubClone
//
//  Created by 김윤홍 on 12/15/24.
//

import UIKit
import FlexLayout

class CustomView: UIView {
    private let rootFlexContainer = UIView()

    // UI Elements
    private let label = UILabel()
    private let button = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        // Add root container
        addSubview(rootFlexContainer)

        // Configure UI elements
        label.text = "Hello, FlexLayout!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        
        button.setTitle("Click Me", for: .normal)

        // FlexLayout setup
        rootFlexContainer.flex.define { flex in
            flex.addItem(label)
                .margin(10)
                .grow(1)
            flex.addItem(button)
                .height(50)
                .marginTop(10)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Set the frame of the root container
        rootFlexContainer.frame = bounds
        // Apply FlexLayout
        rootFlexContainer.flex.layout(mode: .fitContainer)
    }
}
