//
//  Configurable.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import Foundation

protocol Configurable {
    associatedtype ViewModel
    
    func configure(with viewModel: ViewModel)
}
