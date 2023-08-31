//
//  CollectionCellContainer.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 28.08.2023.
//

import UIKit

final class CollectionCellContainer<ItemView: UIView>: UICollectionViewCell, CollectionCell where ItemView: Configurable & Reusable {
    private let itemView = ItemView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init? (coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Override
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemView.prepareForReuse()
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: CollectionCellViewModel) {
        guard let viewModel = viewModel as? ItemView.ViewModel else { return }
        itemView.configure(with: viewModel)
    }
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .clear
        
        contentView.addSubview(itemView)
        let paddings = (itemView as? PaddingsDescribing)?.paddings ?? .zero
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: paddings.top),
            itemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -paddings.bottom),
            itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddings.right),
            itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: paddings.left)
        ])
    }
}

