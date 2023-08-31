//
//  ErrorHandling.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import Foundation

protocol ErrorHandling: BannerShowing {
    func handle(_ error: Error)
    func handleRefreshButtonTapped()
}

extension ErrorHandling {
    func handle(_ error: Error) {
        if let self = self as? EmptyStateErrorDisplaying {
            self.emptyStateErrorView.isHidden = false
        } else {
            showBanner(title: Strings.Common.error, message: error.localizedDescription)
        }
    }
    
    func handleRefreshButtonTapped() {}
}
