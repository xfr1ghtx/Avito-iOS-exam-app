//
//  EmptyStateErrorDisplaying.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import UIKit

protocol EmptyStateErrorDisplaying: AnyObject {
    var emptyStateErrorView: EmptyStateErrorView { get }
    var emptyStateErrorViewContainer: UIView { get }
    
    func setupEmptyStateErrorView()
    func layoutEmptyStateErrorView()
}

extension EmptyStateErrorDisplaying {
    func setupEmptyStateErrorView() {
        emptyStateErrorViewContainer.addSubview(emptyStateErrorView)

        emptyStateErrorView.onDidTapRefreshButton = { [weak self] in
            (self as? ErrorHandling)?.handleRefreshButtonTapped()
        }
    }
    
    func layoutEmptyStateErrorView() {
        emptyStateErrorView.frame = emptyStateErrorViewContainer.bounds
    }
}

extension EmptyStateErrorDisplaying where Self: UIViewController {
    var emptyStateErrorViewContainer: UIView {
        view
    }
}

extension EmptyStateErrorDisplaying where Self: UIView {
    var emptyStateErrorViewContainer: UIView {
        self
    }
}
