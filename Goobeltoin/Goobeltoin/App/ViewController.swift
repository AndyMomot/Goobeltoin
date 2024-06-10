//
//  ViewController.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 10.06.2024.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showSwiftUIView()
    }

    private func showSwiftUIView() {
        let swiftUIViewController = UIHostingController(rootView: ContentView())
        
        // Добавляем новый контроллер как дочерний
        addChild(swiftUIViewController)
        view.addSubview(swiftUIViewController.view)
        swiftUIViewController.didMove(toParent: self)
        
        // Настраиваем ограничения для tabBarViewController
        swiftUIViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swiftUIViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            swiftUIViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            swiftUIViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftUIViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

