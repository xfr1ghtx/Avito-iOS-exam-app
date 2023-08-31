//
//  Product.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import Foundation

struct Product: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageURL: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}
