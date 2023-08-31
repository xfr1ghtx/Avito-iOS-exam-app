//
//  BannerShowing.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import Foundation

protocol BannerShowing {
    func showBanner(title: String?, message: String?)
}

extension BannerShowing {
    func showBanner(title: String?, message: String?) {
        ToastController(title: title, message: message, preferredStyle: .actionSheet).show()
    }
}
