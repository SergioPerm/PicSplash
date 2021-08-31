//
//  PictureDetailInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

import Foundation

/// Протокол для работы с PicturesInteractor
protocol PictureDetailBusinessLogic: AnyObject {
    func loadImage()
}

final class PictureDetailInteractor {
    weak var presenter: PictureDetailPresentationLogic?
    
    var picture: Picture?
    
}

extension PictureDetailInteractor: PictureDetailBusinessLogic {
    func loadImage() {
        guard let picture = picture else { return }
        
        PictureDetailAPI.loadImageData(url: picture.src.large).then { [weak self] response in
            self?.presenter?.showImage(data: response)
        }.catch { error in
            print(error.localizedDescription)
        }
    }
}
