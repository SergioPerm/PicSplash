//
//  PictureDetailAssembly.swift
//  PicSplash
//
//  Created by Sergio Lechini on 31.08.2021.
//

//import Foundation
//import Swinject
//
//class PictureDetailAssembly: Assembly {
//    func assemble(container: Container) {
//        container.register(PictureDetailViewController.self) { r in
//            let view = PictureDetailViewController()
//            view.presenter = r.resolve(PictureDetailPresenter.self)
//            
//            return view
//        }
//        
//        container.register(PictureDetailPresenter.self) { r in
//            let presenter = PictureDetailPresenter()
//            presenter.interactor = r.resolve(PictureDetailInteractor.self)
//            
//            return presenter
//        }
//        
//        container.register(PictureDetailInteractor.self) { r in
//            let interactor = PictureDetailInteractor()
//            return interactor
//        }
//    }
//}
