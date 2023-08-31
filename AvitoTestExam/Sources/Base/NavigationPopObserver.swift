//
//  NavigationPopObserver.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import UIKit

class NavigationPopObserver {
    let observedViewController: UIViewController
    
    private let coordinator: Coordinator
    
    init(observedViewController: UIViewController, coordinator: Coordinator) {
        self.observedViewController = observedViewController
        self.coordinator = coordinator
    }
    
    func didObservePop() {
        coordinator.onDidFinish?()
    }
}
