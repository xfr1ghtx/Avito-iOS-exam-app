//
//  ProductsNetworkProtocol.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import Foundation

protocol ProductsNetworkProtocol {
    func getProducts() async -> Result<ProductResponse, NetworkServiceError>
    func getProduct(by id: String) async -> Result<ProductDetails, NetworkServiceError>
}
