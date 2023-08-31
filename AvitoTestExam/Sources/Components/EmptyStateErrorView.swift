//
//  EmptyStateErrorView.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import UIKit

final class EmptyStateErrorView: UIView {
    // MARK: - Properties
    
    var onDidTapRefreshButton: (() -> Void)?
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let refreshButton = UIButton(type: .system)
    
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
        stackView.frame = bounds
    }
    
    // MARK: - Actions
    
    @objc
    private func tapOnRefreshButton() {
        onDidTapRefreshButton?()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupRefreshButton()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 150, left: 20, bottom: 150, right: 20)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = Strings.Common.error
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 24)
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.text = Strings.Common.errorMessage
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .boldSystemFont(ofSize: 20)
        stackView.addArrangedSubview(subtitleLabel)
    }
    
    private func setupRefreshButton() {
        refreshButton.addTarget(self, action: #selector(tapOnRefreshButton), for: .touchUpInside)
        refreshButton.backgroundColor = .blue
        refreshButton.setTitle(Strings.Common.refresh, for: .normal)
        refreshButton.layer.cornerRadius = 20
        refreshButton.setTitleColor(.white, for: .normal)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refreshButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        stackView.addArrangedSubview(refreshButton)
    }
}
