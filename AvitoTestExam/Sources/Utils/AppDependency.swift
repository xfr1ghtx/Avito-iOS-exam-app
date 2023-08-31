//
//  AppDependency.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 25.08.2023.
//

import Foundation

// MARK: - Protocols

protocol HasProductsNetworkService {
    var productsNetworkService: ProductsNetworkProtocol { get }
}

final class AppDependency {
    // MARK: - Properties
    
    private let networkService: NetworkService
    
    // MARK: - Init
    
    init() {
        networkService = NetworkService()
    }
}

// MARK: - HasProductsNetworkService

extension AppDependency: HasProductsNetworkService {
    var productsNetworkService: ProductsNetworkProtocol {
        networkService
    }
}
