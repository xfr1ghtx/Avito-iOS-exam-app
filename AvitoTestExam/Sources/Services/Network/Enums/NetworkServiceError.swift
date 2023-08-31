//
//  NetworkServiceError.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 26.08.2023.
//

import Foundation

enum NetworkServiceError: LocalizedError {
    
    case notValidURL
    case parsingFailure
    case noInternetConnection
    case networkError
    case timeout

    
    var errorDescription: String? {
        switch self {
        case .notValidURL:
            return Strings.NetworkServiceError.notValidURL
        case .noInternetConnection:
            return Strings.NetworkServiceError.noInternetConnection
        case .parsingFailure:
            return Strings.NetworkServiceError.parsingFailure
        case .networkError:
            return Strings.NetworkServiceError.networkError
        case .timeout:
            return Strings.NetworkServiceError.timeout
        }
    }
}
