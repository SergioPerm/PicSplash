//
//  PictureDetailInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

import Foundation

/// Протокол для работы с PictureDetailInteractor
protocol PictureDetailBusinessLogic: AnyObject {
    /// Загрузить картинку
    func loadImage()
}

final class PictureDetailInteractor {
    weak var presenter: PictureDetailPresentationLogic?
    
    var picture: Picture?
    
    private let networkAPI: PictureDetailNetworking
    
    init(networkAPI: PictureDetailNetworking) {
        self.networkAPI = networkAPI
    }
    
}

// MARK: PictureDetailBusinessLogic
extension PictureDetailInteractor: PictureDetailBusinessLogic {
    /// Загрузить картинку
    func loadImage() {
        guard let picture = picture else { return }
        
        networkAPI.loadImageData(url: picture.src.large).then { [weak self] response in
            self?.presenter?.showImage(data: response)
        }.catch { error in
            print(error.localizedDescription)
        }
    }
}
