//
//  ConfigurableCoordinator.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 25.08.2023.
//

import UIKit

protocol ConfigurableCoordinator: Coordinator {
    associatedtype Configuration
    
    init(navigationController: NavigationController,
         appDependency: AppDependency, configuration: Configuration)
}

extension ConfigurableCoordinator {
    init(navigationController: NavigationController, appDependency: AppDependency) {
        fatalError("Use init with configuration for this coordinator")
    }
}
