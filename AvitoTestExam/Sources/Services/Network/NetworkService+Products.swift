//
//  NetworkService+Products.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import Foundation

extension NetworkService: ProductsNetworkProtocol {
    func getProducts() async -> Result<ProductResponse, NetworkServiceError> {
        await request(method: .GET, url: URLFactory.Products.products)
    }
    
    func getProduct(by id: String) async -> Result<ProductDetails, NetworkServiceError> {
        await request(method: .GET, url: URLFactory.Products.productDetails(withItemID: id))
    }
}
