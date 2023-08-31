//
//  NavigationController.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import UIKit

class NavigationController: UINavigationController {
    // MARK: - Properties
    
    private var popObservers: [NavigationPopObserver] = []
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public methods
    
    func addPopObserver(for viewController: UIViewController, coordinator: Coordinator) {
        let observer = NavigationPopObserver(observedViewController: viewController, coordinator: coordinator)
        popObservers.append(observer)
    }
    
    func removeAllPopObservers() {
        popObservers.removeAll()
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController, animated: Bool) {
        popObservers.forEach { observer in
            if !navigationController.viewControllers.contains(observer.observedViewController) {
                observer.didObservePop()
                popObservers.removeAll { $0 === observer }
            }
        }
    }
}
