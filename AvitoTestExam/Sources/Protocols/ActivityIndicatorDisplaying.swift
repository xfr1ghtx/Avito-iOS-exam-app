//
//  ActivityIndicatorDisplaying.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 30.08.2023.
//

import UIKit

protocol ActivityIndicatorDisplaying {
    var activityIndicatorView: ActivityIndicator { get }
    var activityIndicatorContainerView: UIView { get }
    
    func setupActivityIndicatorView()
    func layoutActivityIndicatorView()
}

extension ActivityIndicatorDisplaying {
    func setupActivityIndicatorView() {
        activityIndicatorContainerView.addSubview(activityIndicatorView)
    }
    
    func layoutActivityIndicatorView() {
        activityIndicatorView.frame = activityIndicatorContainerView.bounds
    }
}

extension ActivityIndicatorDisplaying where Self: UIViewController {
    var activityIndicatorContainerView: UIView {
        view
    }
}

extension ActivityIndicatorDisplaying where Self: UIView {
    var activityIndicatorContainerView: UIView {
        self
    }
}
