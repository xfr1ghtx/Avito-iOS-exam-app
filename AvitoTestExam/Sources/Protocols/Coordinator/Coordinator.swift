//
//  Coordinator.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 25.08.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    // MARK: - Init
    
    init(navigationController: NavigationController,
         appDependency: AppDependency)
    
    // MARK: - Properties
    
    var navigationController: NavigationController { get }
    var appDependency: AppDependency { get set }
    var childCoordinators: [Coordinator] { get set }
    var onDidFinish: (() -> Void)? { get set }
    
    // MARK: - Methods
    
    func start(animated: Bool)
    func add(_ coordinator: Coordinator)
    func remove(_ coordinator: Coordinator)
    
    func show<T: Coordinator>(_ type: T.Type, animated: Bool)
    func show<T: ConfigurableCoordinator>(_ type: T.Type, configuration: T.Configuration, animated: Bool)
    func startCoordinator(_ coordinator: Coordinator, animated: Bool)
    
    func addPopObserver(for viewController: UIViewController)
    func handleCoordinatorFinished()
}

// MARK: - Base methods implementation

extension Coordinator {
    func add(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
    
    func show<T: Coordinator>(_ type: T.Type, animated: Bool) {
        let coordinator = T(navigationController: navigationController, appDependency: appDependency)
        startCoordinator(coordinator, animated: animated)
    }
    
    func show<T: ConfigurableCoordinator>(_ type: T.Type, configuration: T.Configuration, animated: Bool) {
        let coordinator = T(navigationController: navigationController, appDependency: appDependency,
                            configuration: configuration)
        startCoordinator(coordinator, animated: animated)
    }
    
    func startCoordinator(_ coordinator: Coordinator, animated: Bool) {
        add(coordinator)
        coordinator.onDidFinish = { [weak self, weak coordinator] in
            guard let coordinator = coordinator else { return }
            coordinator.handleCoordinatorFinished()
            self?.remove(coordinator)
        }
        coordinator.start(animated: animated)
    }
    
    func addPopObserver(for viewController: UIViewController) {
        navigationController.addPopObserver(for: viewController, coordinator: self)
    }
    
    func handleCoordinatorFinished() {}
}
