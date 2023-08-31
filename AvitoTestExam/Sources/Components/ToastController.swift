//
//  ToastController.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import UIKit

final class ToastController: UIAlertController {
    // MARK: - Properties
    
    let window: UIWindow? = {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene.map(UIWindow.init(windowScene: ))
        
        window?.isUserInteractionEnabled = false
        window?.rootViewController = UIViewController()
        window?.windowLevel = .alert + 1
        window?.makeKeyAndVisible()
        
        return window
    }()
    
    // MARK: - Public methods
    
    func show() {
        window?.rootViewController?.present(self, animated: false)
        
        Task {
            try await Task.sleep(for: .seconds(3))
            dismiss(animated: false)
        }
    }
}
