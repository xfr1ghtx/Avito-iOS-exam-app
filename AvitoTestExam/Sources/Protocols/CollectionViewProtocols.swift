//
//  CollectionViewProtocols.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import Foundation

// MARK: - CollectionCellViewModel

protocol CollectionCellViewModel {
    var collectionReuseIdentifier: String { get }
    func select()
}

extension CollectionCellViewModel {
    func select() {}
}

// MARK: - CollectionCell

protocol CollectionCell {
    func configure(with viewModel: CollectionCellViewModel)
}
