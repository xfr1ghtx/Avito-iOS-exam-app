//
//  ProductResponse.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import Foundation

struct ProductResponse: Decodable {
    let advertisements: [Product]
}
