//
//  URLFactory.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 26.08.2023.
//

import Foundation

enum URLFactory {
    private static let baseURL = "https://www.avito.st/s/interns-ios"
    
    enum Products {
        static let products = baseURL + "/main-page.json"
        static func productDetails(withItemID id: String) -> String {
            return baseURL + "/details/" + id + ".json"
        }
    }
}
