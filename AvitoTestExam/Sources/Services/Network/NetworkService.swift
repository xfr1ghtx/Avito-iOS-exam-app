//
//  NetworkService.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 26.08.2023.
//

import Foundation

final class NetworkService {
    // MARK: - Make request
    
    func request<T:Decodable>(method: HTTPMethod, url: String) async -> Result<T, NetworkServiceError> {
        guard let url = URL(string: url) else { return .failure(.notValidURL) }
        var request = URLRequest(url: url, timeoutInterval: 15)
        request.httpMethod = method.rawValue
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return decode(data, ofType: T.self)
        } catch {
            switch (error as? URLError)?.code {
            case .some(.notConnectedToInternet):
                return .failure(.noInternetConnection)
            case .some(.timedOut):
                return .failure(.timeout)
            default:
                return .failure(.networkError)
            }
        }
    }
    
    // MARK: - Decoding data
    
    private func decode<T: Decodable>(_ data: Data, ofType type: T.Type) -> Result<T, NetworkServiceError> {
        guard let object = try? JSONDecoder().decode(type.self, from: data) else {
            return .failure(.parsingFailure)
        }
        return .success(object)
    }
}
