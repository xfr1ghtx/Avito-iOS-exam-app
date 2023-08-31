//
//  DataLoadingView.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import Foundation

protocol DataLoadingView: AnyObject {
    func bind(to viewModel: DataLoadingViewModel)
    func handleStartLoading()
    func handleFinishLoading()
    func handleReceiveError()
    func handleLoadData()
}

extension DataLoadingView where Self: ActivityIndicatorDisplaying & ErrorHandling {
    func bind(to viewModel: DataLoadingViewModel) {
        viewModel.onDidStartLoading = { [weak self] in
            DispatchQueue.main.async {
                (self as? EmptyStateErrorDisplaying)?.emptyStateErrorView.isHidden = true
                self?.activityIndicatorView.isHidden = false
                self?.activityIndicatorView.startAnimation()
            }
            self?.handleStartLoading()
        }
        
        viewModel.onDidFinishLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicatorView.isHidden = true
                self?.activityIndicatorView.stopAnimation()
            }
            self?.handleFinishLoading()
        }

        viewModel.onDidLoadData = { [weak self] in
            self?.handleLoadData()
        }

        viewModel.onDidReceiveError = { [weak self] error in
            self?.handle(error)
            self?.handleReceiveError()
        }
    }
    
    func handleStartLoading() {}
    func handleFinishLoading() {}
    func handleReceiveError() {}
    func handleLoadData() {}
}
