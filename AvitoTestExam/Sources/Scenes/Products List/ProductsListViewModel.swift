//
//  ProductsListViewModel.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 25.08.2023.
//

import Foundation

protocol ProductsListViewModelDelegate: AnyObject {
    func productsListViewModel(_ viewModel: ProductsListViewModel,
                               didRequestToShowProductWith id: String,
                               and title: String)
}

final class ProductsListViewModel: DataLoadingViewModel {
    typealias Dependency = HasProductsNetworkService
    
    // MARK: - Properties
    
    var onDidStartLoading: (() -> Void)?
    var onDidFinishLoading: (() -> Void)?
    var onDidLoadData: (() -> Void)?
    var onDidReceiveError: ((Error) -> Void)?
    
    var productViewModels: [ProductCardViewModel] = []
    
    weak var delegate: ProductsListViewModelDelegate?
    
    private let dependency: Dependency
    
    // MARK: - Init
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    // MARK: - Public methods
    
    func loadData(isRefreshing: Bool = false) {
        if isRefreshing == false {
            onDidStartLoading?()
        }
        Task {
            await loadProducts()
        }
    }
    
    // MARK: - Private methods
    
    private func loadProducts() async {
        let result = await dependency.productsNetworkService.getProducts()
        switch result {
        case .success(let success):
            await handle(success.advertisements)
        case .failure(let failure):
            await handle(failure)
        }
    }
    
    @MainActor
    private func handle(_ products: [Product]) {
        productViewModels = products.map {
            let viewModel = ProductCardViewModel(product: $0)
            viewModel.delegate = self
            return viewModel
        }
        onDidLoadData?()
        onDidFinishLoading?()
    }
    
    @MainActor
    private func handle(_ error: Error) {
        onDidReceiveError?(error)
        onDidFinishLoading?()
    }
}

// MARK: - ProductCardViewModelDelegate

extension ProductsListViewModel: ProductCardViewModelDelegate {
    func productCardViewModel(_ viewModel: ProductCardViewModel,
                              didRequestToShowProductDetailsWith id: String,
                              and title: String) {
        delegate?.productsListViewModel(self, didRequestToShowProductWith: id, and: title)
    }
}
