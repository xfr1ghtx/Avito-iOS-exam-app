//
//  MainCoordinator.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 25.08.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: - Properties
    
    var navigationController: NavigationController
    var appDependency: AppDependency
    
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    // MARK: - Init
    
    init(navigationController: NavigationController,
         appDependency: AppDependency = AppDependency()) {
        self.navigationController = navigationController
        self.appDependency = appDependency
    }
    
    // MARK: - Navigation
    
    func start(animated: Bool) {
        showProductsListScreen(animated: animated)
    }
    
    private func showProductsListScreen(animated: Bool) {
        show(ProductsListCoordinator.self, animated: true)
    }
}
