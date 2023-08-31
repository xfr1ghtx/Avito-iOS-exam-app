//
//  CollectionView.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import UIKit

enum DefaultCollectionSection {
    case main
}

protocol CollectionViewDelegate: AnyObject {
    func collectionView(didSelectItemAt indexPath: IndexPath)
}

final class CollectionView<Cell: UICollectionViewCell & CollectionCell,
                            Section: Hashable,
                           Model: Hashable & CollectionCellViewModel>: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    weak var delegate: CollectionViewDelegate?
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Model>?
    
    private var collectionView: UICollectionView?
    
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
        collectionView?.frame = bounds
    }
    
    // MARK: - Public methods
    
    func createSnapshot() -> NSDiffableDataSourceSnapshot<Section, Model> {
        return NSDiffableDataSourceSnapshot<Section, Model>()
    }
    
    func apply(_ snapshot: NSDiffableDataSourceSnapshot<Section, Model>, animated: Bool = false) {
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        
        return CGSize(width: (width / 2) - 15 , height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView(didSelectItemAt: indexPath)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView.delegate = self
        dataSource = UICollectionViewDiffableDataSource<Section, Model>(collectionView: collectionView) { collectionView, indexPath, viewModel in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
                return UICollectionViewCell()
            }
            cell.configure(with: viewModel)
            return cell
        }
        addSubview(collectionView)
    }
}
