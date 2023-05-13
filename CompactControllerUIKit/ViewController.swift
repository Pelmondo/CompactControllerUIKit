//
//  ViewController.swift
//  CompactControllerUIKit
//
//  Created by Сергей Прокопьев on 13.05.2023.
//

import UIKit

class ViewController: UIViewController {

    private lazy var button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)

        button.setTitle("Present", for: .normal)
        button.addAction(.init(handler: { _ in
            let contentVC = SecondViewController()
            contentVC.modalPresentationStyle = .popover
            contentVC.preferredContentSize = CGSize(width: 300, height: 280)
            contentVC.popoverPresentationController?.sourceView = self.button
            contentVC.popoverPresentationController?.sourceRect = self.button.bounds
            contentVC.popoverPresentationController?.delegate = contentVC

            self.present(contentVC, animated: true, completion: nil)
        }), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        button.frame = .init(x: 0, y: view.layoutMargins.top, width: 100, height: 42)
        button.center.x = view.center.x
    }
}

extension SecondViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func popoverPresentationController(_ popoverPresentationController: UIPopoverPresentationController, willChangeContentSizeFrom oldSize: CGSize, to newSize: CGSize) {
            UIView.animate(withDuration: 0.25, animations: {
                self.preferredContentSize = newSize
            })
        }
}

class SecondViewController: UIViewController {

    private lazy var control = UISegmentedControl(items: ["280pt", "150pt"])
    private lazy var dissmissButton = UIButton(type: .close)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground

        view.addSubview(control)
        view.addSubview(dissmissButton)

        dissmissButton.addAction(.init(handler: { _ in
            self.dismiss(animated: true)
        }), for: .touchUpInside)

        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(controlValueChanged(_ :)), for: .valueChanged)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        control.frame = .init(x: 0, y: view.layoutMargins.top, width: 120, height: 32)
        control.center.x = view.center.x

        dissmissButton.frame = .init(x: 0, y: view.layoutMargins.top, width: 28, height: 28)
        dissmissButton.center.x = view.frame.width - view.layoutMargins.right
        dissmissButton.center.y = control.center.y
    }

    @objc private func controlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 0.3) {
                self.preferredContentSize =  CGSize(width: 300, height: 280)
            }
        case 1:
            UIView.animate(withDuration: 0.3) {
                self.preferredContentSize =  CGSize(width: 300, height: 150)
            }
        default:
            return
        }
    }
}

