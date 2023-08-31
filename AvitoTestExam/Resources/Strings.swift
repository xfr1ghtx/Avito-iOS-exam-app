//
//  Strings.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import Foundation

enum Strings {
    enum Common {
        static let error = NSLocalizedString("Error", tableName: "Common", comment: "")
        static let errorMessage = NSLocalizedString("ErrorMessage", tableName: "Common", comment: "")
        static let refresh = NSLocalizedString("Refresh",tableName: "Common", comment: "")
    }
    
    enum ProductList {
        static let screenTitle = NSLocalizedString("screenTitle", tableName: "Product List", comment: "")
    }
    
    enum ProductDetails {
        static let descriptionLabelText =  NSLocalizedString("descriptionLabel.text", tableName: "Product Details", comment: "")
        static let writeButtonText = NSLocalizedString("writeButton.text", tableName: "Product Details", comment: "")
        static let callButtonText = NSLocalizedString("callButton.text", tableName: "Product Details", comment: "")
    }
    
    enum NetworkServiceError {
        static let notValidURL = NSLocalizedString("networkServiceError.notValidURL", tableName: "Common", comment: "")
        static let noInternetConnection = NSLocalizedString("networkServiceError.noInternetConnection", tableName: "Common", comment: "")
        static let parsingFailure = NSLocalizedString("networkServiceError.parsingFailure", tableName: "Common", comment: "")
        static let networkError = NSLocalizedString("networkServiceError.networkError", tableName: "Common", comment: "")
        static let timeout = NSLocalizedString("networkServiceError.timeout", tableName: "Common", comment: "")
    }
}
