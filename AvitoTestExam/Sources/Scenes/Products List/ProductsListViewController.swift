//
//  ProductsListViewController.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 25.08.2023.
//

import UIKit

final class ProductsListViewController: BaseViewController, DataLoadingView,
                                            ActivityIndicatorDisplaying, ErrorHandling, EmptyStateErrorDisplaying {
    // MARK: - Properties
    
    var activityIndicatorView = ActivityIndicator()
    var activityIndicatorContainerView = UIView()
    
    var emptyStateErrorView = EmptyStateErrorView()
    var emptyStateErrorViewContainer = UIView()
    
    private let collectionView = CollectionView<ProductCardCell, DefaultCollectionSection, ProductCardViewModel>()
    
    private let viewModel: ProductsListViewModel
    
    // MARK: - Init
    
    init(viewModel: ProductsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ProductsListViewController init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind(to: viewModel)
        setup()
        viewModel.loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
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
        var snapshot = collectionView.createSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.productViewModels, toSection: .main)
        collectionView.apply(snapshot)
    }
    
    func handleRefreshButtonTapped() {
        viewModel.loadData(isRefreshing: true)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupCollectionView()
        setupActivityIndicatorContainerView()
        setupActivityIndicatorView()
        setupEmptyStateErrorContainerView()
        setupEmptyStateErrorView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
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
    
    private func layout() {
        layoutCollectionView()
        layoutActivityIndicatorContainerView()
        layoutActivityIndicatorView()
        layoutEmptyStateErrorContainerView()
        layoutEmptyStateErrorView()
    }
    
    private func layoutCollectionView() {
        collectionView.frame = view.bounds
    }
    
    private func layoutActivityIndicatorContainerView() {
        activityIndicatorContainerView.frame = view.bounds
    }
    
    private func layoutEmptyStateErrorContainerView() {
        emptyStateErrorViewContainer.frame = view.bounds
    }
}

extension ProductsListViewController: CollectionViewDelegate {
    func collectionView(didSelectItemAt indexPath: IndexPath) {
        viewModel.productViewModels[indexPath.item].select()
    }
}
