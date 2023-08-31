//
//  ProductCardViewModel.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import Foundation

protocol ProductCardViewModelDelegate: AnyObject {
    func productCardViewModel(_ viewModel: ProductCardViewModel,
                              didRequestToShowProductDetailsWith id: String, and title: String)
}

final class ProductCardViewModel {
    // MARK: - Properties
    
    var id: String {
        product.id
    }
    
    var title: String {
        product.title
    }
    
    var price: String {
        product.price
    }
    
    var location: String {
        product.location
    }
    
    var imageURL: URL? {
        URL(string: product.imageURL)
    }
    
    var createdDate: String {
        var formatter = DateFormatter.yearMonthDayISO
        let date = formatter.date(from: product.createdDate)
        formatter = DateFormatter.dayMonthYearDisplay
        guard let date = date else { return product.createdDate }
        return formatter.string(from: date)
    }
    
    weak var delegate: ProductCardViewModelDelegate?
    
    private let product: Product
    
    // MARK: - Init
    
    init(product: Product) {
        self.product = product
    }
    
    // MARK: - Public methods
    
    func select() {
        delegate?.productCardViewModel(self, didRequestToShowProductDetailsWith: product.id, and: title)
    }
}

// MARK: - CollectionCellViewModel

extension ProductCardViewModel: CollectionCellViewModel {
    var collectionReuseIdentifier: String {
        ProductCardCell.reuseIdentifier
    }
}

// MARK: - Hashable

extension ProductCardViewModel: Hashable {
    static func == (lhs: ProductCardViewModel, rhs: ProductCardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
