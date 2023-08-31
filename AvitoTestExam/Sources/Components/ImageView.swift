//
//  ImageView.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 30.08.2023.
//

import UIKit

final class ImageView: UIView, ActivityIndicatorDisplaying {
    // MARK: - Properties
    
    var activityIndicatorView = ActivityIndicator()
    var activityIndicatorContainerView = UIView()
    
    private let imageView = UIImageView()
    private var loadTask: Task<(), Never>?
    
    var image: UIImage? {
        get {
            imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
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
        layout()
    }
    
    // MARK: - Public methods
    
    func stopLoad() {
        self.loadTask?.cancel()
    }
    
    func setImage(with url: URL?) {
        self.loadTask?.cancel()
        loadTask = Task.detached(priority: .high) { [weak self] in
            await self?.showActivityIndicator()
            guard let url = url else {
                await self?.handleDownloadError()
                return
            }
            let result = await self?.downloadImage(from: url)
            switch result {
            case .success(let image):
                await self?.setDownloadedImage(image)
            case .failure(let error):
                if error.errorCode == -999 { return }
                await self?.handleDownloadError()
            case .none:
                return
            }
        }
    }
    
    // MARK: - Private methods
    
    @MainActor
    private func setDownloadedImage(_ image: UIImage) {
        self.image = image
        hideActivityIndicator()
    }
    
    @MainActor
    private func handleDownloadError() {
        self.image = Images.imageDownloadError
        hideActivityIndicator()
    }
    
    private func downloadImage(from url: URL) async -> Result<UIImage, URLError> {
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
            return await decodeDataToImage(data)
        } catch {
            return .failure(error as! URLError)
        }
    }
    
    private func decodeDataToImage(_ data: Data) async -> Result<UIImage, URLError> {
        guard let image = UIImage(data: data) else {
            return .failure(URLError(.cannotDecodeContentData))
        }
        return .success(image)
    }
    
    @MainActor
    private func showActivityIndicator() {
        activityIndicatorContainerView.isHidden = false
        activityIndicatorView.startAnimation()
    }
    
    @MainActor
    private func hideActivityIndicator() {
        activityIndicatorContainerView.isHidden = true
        activityIndicatorView.stopAnimation()
    }
    
    // MARK: - Layout
    
    private func layout() {
        layoutImageView()
        layoutActivityIndicatorContainerView()
        layoutActivityIndicatorView()
    }
    
    private func layoutImageView() {
        imageView.frame = bounds
    }
    
    private func layoutActivityIndicatorContainerView() {
        activityIndicatorContainerView.frame = bounds
    }
    
    // MARK: - Setup
    
    private func setup() {
        layer.masksToBounds = true
        setupImageView()
        setupActivityIndicatorContainerView()
        setupActivityIndicatorView()
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
    }
    
    private func setupActivityIndicatorContainerView() {
        addSubview(activityIndicatorContainerView)
        activityIndicatorContainerView.backgroundColor = .gray.withAlphaComponent(0.5)
        activityIndicatorContainerView.isHidden = true
    }
}
