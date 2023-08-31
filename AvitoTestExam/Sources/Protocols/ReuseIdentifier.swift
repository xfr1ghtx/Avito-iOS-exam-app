//
//  ReuseIdentifier.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifiable {}
