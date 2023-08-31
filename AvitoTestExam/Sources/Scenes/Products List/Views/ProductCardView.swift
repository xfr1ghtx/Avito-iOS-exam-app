//
//  ProductCardView.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import UIKit

typealias ProductCardCell = CollectionCellContainer<ProductCardView>

final class ProductCardView: UIView, Configurable, Reusable {
    // MARK: - Properties
    
    private let stackViewContainer = UIStackView()
    private let textStackView = UIStackView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let locationLabel = UILabel()
    private let imageView = ImageView()
    private let createdDateLabel = UILabel()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: ProductCardViewModel) {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        locationLabel.text = viewModel.location
        imageView.setImage(with: viewModel.imageURL)
        createdDateLabel.text = viewModel.createdDate
    }
    
    // MARK: - Reusable
    
    func prepareForReuse() {
        titleLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        imageView.stopLoad()
        imageView.image = nil
        createdDateLabel.text = nil
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupSuperView()
        setupStackViewContainer()
        setupImageView()
        setupTextStackView()
        setupTitleLabel()
        setupPriceLabel()
        setupLocationLabel()
        setupCreatedDateLabel()
    }
    
    private func setupSuperView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.cornerCurve = .continuous
    }
    
    private func setupStackViewContainer() {
        addSubview(stackViewContainer)
        stackViewContainer.axis = .vertical
        stackViewContainer.spacing = 5
        stackViewContainer.alignment = .fill
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: topAnchor),
            stackViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupTextStackView() {
        stackViewContainer.addArrangedSubview(textStackView)
        textStackView.axis = .vertical
        textStackView.spacing = 5
        textStackView.isLayoutMarginsRelativeArrangement = true
        textStackView.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 0)
    }
    
    private func setupTitleLabel() {
        textStackView.addArrangedSubview(titleLabel)
        titleLabel.numberOfLines = 2
    }
    
    private func setupPriceLabel() {
        textStackView.addArrangedSubview(priceLabel)
    }
    
    private func setupLocationLabel() {
        textStackView.addArrangedSubview(locationLabel)
    }
    
    private func setupImageView() {
        stackViewContainer.addArrangedSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setupCreatedDateLabel() {
        textStackView.addArrangedSubview(createdDateLabel)
    }
}

// MARK: - PaddingsDescribing

extension ProductCardView: PaddingsDescribing {
    var paddings: UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
