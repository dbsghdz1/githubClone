//
//  ViewController.swift
//  githubClone
//
//  Created by 김윤홍 on 12/15/24.
//

import UIKit
import PinLayout
import FlexLayout
import RxCocoa
import Kingfisher

final class LoginViewController: UIViewController {
    private let customView = CustomView()
    
    override func loadView() {
            // Set customView as the view of the controller
            self.view = customView
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            // Additional setup
            customView.backgroundColor = .white

            // Example: Adding action to the button
            if let button = customView.subviews.first(where: { $0 is UIButton }) as? UIButton {
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            }
        }

        @objc private func buttonTapped() {
            print("Button was tapped!")
        }
}
