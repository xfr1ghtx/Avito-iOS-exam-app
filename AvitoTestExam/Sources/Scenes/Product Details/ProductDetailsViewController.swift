//
//  ProductDetailsViewController.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import UIKit

final class ProductDetailsViewController: BaseViewController, DataLoadingView,
                                          ActivityIndicatorDisplaying, ErrorHandling, EmptyStateErrorDisplaying  {
    // MARK: - Properties
    
    let activityIndicatorView = ActivityIndicator()
    let activityIndicatorContainerView = UIView()
    
    let emptyStateErrorView = EmptyStateErrorView()
    let emptyStateErrorViewContainer = UIView()
    
    private let viewModel: ProductDetailsViewModel
    
    private let scrollView = UIScrollView()
    private let stackViewContainer = UIStackView()
    private let imageView = ImageView()
    private let textStackView = UIStackView()
    private let priceLabel = UILabel()
    private let titleLabel = UILabel()
    private let locationAddressLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let callButton = UIButton()
    private let writeButton = UIButton()
    private let descriptionTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let createdDateLabel = UILabel()
    
    
    // MARK: - Init
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ProductDetailsViewController init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindToViewModel()
        viewModel.loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
        layoutActivityIndicatorContainerView()
        layoutActivityIndicatorView()
        layoutEmptyStateErrorContainerView()
        layoutEmptyStateErrorView()
    }
    
    // MARK: - Public methods
    
    func handleStartLoading() {
        activityIndicatorContainerView.isHidden = false
        emptyStateErrorViewContainer.isHidden = true
    }
    
    func handleFinishLoading() {
        activityIndicatorContainerView.isHidden = true
    }
    
    func handleReceiveError() {
        emptyStateErrorViewContainer.isHidden = false
    }
    
    func handleLoadData() {
        emptyStateErrorViewContainer.isHidden = true
        guard let details = viewModel.productDetails else { return }
        imageView.setImage(with: details.imageURL)
        priceLabel.text = details.price
        titleLabel.text = details.title
        locationAddressLabel.text = details.location + "\n" + details.address
        descriptionLabel.text = details.description
        createdDateLabel.text = details.dispayDate
    }
    
    func handleRefreshButtonTapped() {
        viewModel.loadData(isRefreshing: true)
    }
    
    // MARK: - Private methods
    
    private func bindToViewModel() {
        bind(to: viewModel)
        viewModel.onNeedsToOpenURL = { url in
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Action
    
    @objc
    private func tapOnCallButton() {
        viewModel.tapOnCall()
    }
    
    @objc
    private func tapOnWriteButton() {
        viewModel.tapOnWrite()
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.backgroundColor = .white
        setupScrollView()
        setupStackViewContainer()
        setupImageView()
        setupTextStackView()
        setupPriceLabel()
        setupTitleLabel()
        setupLocationAddressLabel()
        setupButtonStackView()
        setupCallButton()
        setupWriteButton()
        setupDescriptionTitleLabel()
        setupDescriptionLabel()
        setupCreatedDateLabel()
        setupActivityIndicatorContainerView()
        setupActivityIndicatorView()
        setupEmptyStateErrorContainerView()
        setupEmptyStateErrorView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
    }
    
    private func setupStackViewContainer() {
        scrollView.addSubview(stackViewContainer)
        stackViewContainer.axis = .vertical
        stackViewContainer.spacing = 16
        stackViewContainer.isLayoutMarginsRelativeArrangement = true
        stackViewContainer.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackViewContainer.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
    }
    
    private func setupImageView() {
        stackViewContainer.addArrangedSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func setupTextStackView() {
        stackViewContainer.addArrangedSubview(textStackView)
        textStackView.axis = .vertical
        textStackView.spacing = 10
        textStackView.isLayoutMarginsRelativeArrangement = true
        textStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private func setupPriceLabel() {
        textStackView.addArrangedSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 30, weight: .bold)
        textStackView.setCustomSpacing(5, after: priceLabel)
    }
    
    private func setupTitleLabel() {
        textStackView.addArrangedSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 24, weight: .regular)
        titleLabel.numberOfLines = 0
        textStackView.setCustomSpacing(15, after: titleLabel)
    }
    
    private func setupLocationAddressLabel() {
        textStackView.addArrangedSubview(locationAddressLabel)
        locationAddressLabel.numberOfLines = 0
        textStackView.setCustomSpacing(15, after: locationAddressLabel)
    }
    private func setupButtonStackView() {
        textStackView.addArrangedSubview(buttonStackView)
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 16
        buttonStackView.distribution = .fillEqually
        textStackView.setCustomSpacing(15, after: buttonStackView)
    }
    private func setupCallButton() {
        buttonStackView.addArrangedSubview(callButton)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.layer.cornerRadius = 8
        callButton.backgroundColor = .systemGreen
        callButton.setTitle(Strings.ProductDetails.callButtonText, for: .normal)
        callButton.addTarget(self, action: #selector(tapOnCallButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    private func setupWriteButton() {
        buttonStackView.addArrangedSubview(writeButton)
        writeButton.translatesAutoresizingMaskIntoConstraints = false
        writeButton.layer.cornerRadius = 8
        writeButton.backgroundColor = .lightGray
        writeButton.setTitle(Strings.ProductDetails.writeButtonText, for: .normal)
        writeButton.addTarget(self, action: #selector(tapOnWriteButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            writeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    private func setupDescriptionTitleLabel() {
        textStackView.addArrangedSubview(descriptionTitleLabel)
        descriptionTitleLabel.text = Strings.ProductDetails.descriptionLabelText
        descriptionTitleLabel.font = .systemFont(ofSize: 27, weight: .bold)
    }
    private func setupDescriptionLabel() {
        textStackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 18)
        textStackView.setCustomSpacing(20, after: descriptionLabel)
    }
    private func setupCreatedDateLabel() {
        textStackView.addArrangedSubview(createdDateLabel)
        createdDateLabel.numberOfLines = 0
        createdDateLabel.font = .systemFont(ofSize: 14)
        
    }
    private func setupActivityIndicatorContainerView() {
        view.addSubview(activityIndicatorContainerView)
        activityIndicatorContainerView.backgroundColor = .gray.withAlphaComponent(0.5)
        activityIndicatorContainerView.isHidden = true
    }
    private func setupEmptyStateErrorContainerView() {
        view.addSubview(emptyStateErrorViewContainer)
        emptyStateErrorViewContainer.backgroundColor = .white
        emptyStateErrorViewContainer.isHidden = true
    }
    
    // MARK: - Layout
    
    private func layoutActivityIndicatorContainerView() {
        activityIndicatorContainerView.frame = view.bounds
    }
    
    private func layoutEmptyStateErrorContainerView() {
        emptyStateErrorViewContainer.frame = view.bounds
    }
}
