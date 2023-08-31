//
//  DataLoadingViewModel.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import Foundation

protocol DataLoadingViewModel: AnyObject {
    var onDidStartLoading: (() -> Void)? { get set }
    var onDidFinishLoading: (() -> Void)? { get set }
    var onDidLoadData: (() -> Void)? { get set }
    var onDidReceiveError: ((Error) -> Void)? { get set }
}
