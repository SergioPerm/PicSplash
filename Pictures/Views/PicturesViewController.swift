//
//  PicturesViewController.swift
//  PicSplash
//
//  Created by Sergio Lechini on 27.08.2021.
//

import UIKit

/// Протокол отображения MenuViewController-а
protocol PicturesDisplayLogic: AnyObject {
    
}

class PicturesViewController: UIViewController {

    // MARK Presenter
    var presenter: PicturesViewControllerOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }

}

// MARK: PicturesDisplayLogic
extension PicturesViewController: PicturesDisplayLogic {
    
}
