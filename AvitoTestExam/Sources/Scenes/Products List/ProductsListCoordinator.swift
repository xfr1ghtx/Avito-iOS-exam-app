//
//  ProductsListCoordinator.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 25.08.2023.
//

import UIKit

final class ProductsListCoordinator: Coordinator {
    // MARK: - Properties
    
    var navigationController: NavigationController
    var appDependency: AppDependency
    
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    // MARK: - Init
    
    init(navigationController: NavigationController, appDependency: AppDependency) {
        self.navigationController = navigationController
        self.appDependency = appDependency
    }
    
    // MARK: - Navigation
    
    func start(animated: Bool) {
        showProductsListScreen(animated: animated)
    }
    
    private func showProductsListScreen(animated: Bool) {
        let viewModel = ProductsListViewModel(dependency: appDependency)
        viewModel.delegate = self
        let viewController = ProductsListViewController(viewModel: viewModel)
        viewController.title = Strings.ProductList.screenTitle
        addPopObserver(for: viewController)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    private func showProductDetailsScreen(with id: String, and title: String, animated: Bool) {
        let configuration = ProductDetailsCoordinatorConfiguration(id: id, title: title)
        show(ProductDetailsCoordinator.self, configuration: configuration, animated: true)
    }
}

// MARK: - ProductsListViewModelDelegate

extension ProductsListCoordinator: ProductsListViewModelDelegate {
    func productsListViewModel(_ viewModel: ProductsListViewModel,
                               didRequestToShowProductWith id: String,
                               and title: String) {
        showProductDetailsScreen(with: id, and: title, animated: true)
    }
}
