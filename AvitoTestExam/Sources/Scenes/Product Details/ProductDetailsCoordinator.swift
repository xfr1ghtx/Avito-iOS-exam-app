//
//  ProductDetailsCoordinator.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import Foundation

struct ProductDetailsCoordinatorConfiguration {
    let id: String
    let title: String
}

final class ProductDetailsCoordinator: ConfigurableCoordinator {
    typealias Configuration = ProductDetailsCoordinatorConfiguration
    
    // MARK: - Properties
    
    var navigationController: NavigationController
    var appDependency: AppDependency
    
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    private let configuration: Configuration
    
    // MARK: - Init
    
    init(navigationController: NavigationController, appDependency: AppDependency, configuration: ProductDetailsCoordinatorConfiguration) {
        self.navigationController = navigationController
        self.appDependency = appDependency
        self.configuration = configuration
    }
    
    // MARK: - Navigation
    
    func start(animated: Bool) {
        showProductDetailScreen(animated: animated)
    }
    
    private func showProductDetailScreen(animated: Bool) {
        let viewModel = ProductDetailsViewModel(dependencies: appDependency, id: configuration.id)
        let viewController = ProductDetailsViewController(viewModel: viewModel)
        viewController.title = configuration.title
        addPopObserver(for: viewController)
        navigationController.pushViewController(viewController, animated: animated)
    }
}
