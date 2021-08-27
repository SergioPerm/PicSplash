//
//  PicturesInteractor.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import Foundation

/// Протокол для работы с MenuInteractor
protocol PicturesBusinessLogic { }

final class PicturesInteractor {
    weak var presenter: PicturesPresentationLogic?
}

// MARK: MenuBusinessLogic
extension PicturesInteractor: PicturesBusinessLogic { }
