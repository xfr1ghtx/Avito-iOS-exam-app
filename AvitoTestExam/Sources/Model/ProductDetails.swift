//
//  ProductDetails.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import Foundation

struct ProductDetails: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageStringURL: String
    let createdDate: String
    let description: String
    let email: String
    let phoneNumber: String
    let address: String
    
    var imageURL: URL? {
        URL(string: imageStringURL)
    }
    
    var dispayDate: String {
        var formatter = DateFormatter.yearMonthDayISO
        let date = formatter.date(from: createdDate)
        formatter = DateFormatter.dayMonthYearDisplay
        guard let date = date else { return createdDate }
        return formatter.string(from: date)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, location, description, email, address
        case imageStringURL = "image_url"
        case createdDate = "created_date"
        case phoneNumber = "phone_number"
    }
}

