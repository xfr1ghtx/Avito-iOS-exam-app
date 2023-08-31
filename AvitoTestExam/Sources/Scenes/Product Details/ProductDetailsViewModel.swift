//
//  ProductDetailsViewModel.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import Foundation

final class ProductDetailsViewModel: DataLoadingViewModel {
    typealias Dependencies = HasProductsNetworkService
    // MARK: - Properties
    
    var onDidStartLoading: (() -> Void)?
    var onDidFinishLoading: (() -> Void)?
    var onDidReceiveError: ((Error) -> Void)?
    var onDidLoadData: (() -> Void)?
    
    var onNeedsToOpenURL: ((_ url: URL) -> Void)?
    
    private(set) var productDetails: ProductDetails?
    
    private let dependencies: Dependencies
    private let id: String
    
    // MARK: - Init
    
    init(dependencies: Dependencies, id: String) {
        self.dependencies = dependencies
        self.id = id
    }
    
    // MARK: - Public methods
    
    func loadData(isRefreshing: Bool = false) {
        if isRefreshing == false {
            onDidStartLoading?()
        }
        Task {
            await loadProductDetails()
        }
    }
    
    func tapOnCall() {
        guard let phone = productDetails?.phoneNumber,
                let url = URL(string: "tel:\(phone.filter("+0123456789".contains))") else { return }
        onNeedsToOpenURL?(url)
    }
    
    func tapOnWrite() {
        guard let email = productDetails?.email, let url = URL(string: "mailto:\(email)") else { return }
        onNeedsToOpenURL?(url)
    }
    
    // MARK: - Private methods
    
    private func loadProductDetails() async {
        let result = await dependencies.productsNetworkService.getProduct(by: id)
        switch result {
        case .success(let details):
            await handle(details)
        case .failure(let error):
            await handle(error)
        }
    }
    
    @MainActor
    private func handle(_ details: ProductDetails) {
        self.productDetails = details
        onDidLoadData?()
        onDidFinishLoading?()
    }
    
    @MainActor
    private func handle(_ error: Error) {
        onDidReceiveError?(error)
        onDidFinishLoading?()
    }
}
