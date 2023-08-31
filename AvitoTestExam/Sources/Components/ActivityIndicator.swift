//
//  ActivityIndicator.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 30.08.2023.
//

import UIKit

final class ActivityIndicator: UIView {
    // MARK: - Properties
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Override
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // MARK: - Public methods
    
    func startAnimation() {
        activityIndicator.startAnimating()
        isHidden = false
    }
    
    func stopAnimation() {
        activityIndicator.stopAnimating()
        isHidden = true
    }
    
    // MARK: - Setup
    
    private func setup() {
        addSubview(activityIndicator)
    }
    
    // MARK: - Layout
    
    private func layout() {
        activityIndicator.frame = .init(x: bounds.width / 2 - 20, y: bounds.height / 2 - 20, width: 40, height: 40)
    }
}
