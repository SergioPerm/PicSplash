//
//  PicturesRouterTest.swift
//  PicSplashTests
//
//  Created by Sergio Lechini on 06.09.2021.
//

@testable import PicSplash
import SwiftLazy
import XCTest

class PicturesRouterTest: XCTestCase {

    var sup: PicturesRouter!
    var globalNavController: GlobalNavigationViewController = AppDI.resolve()
    
    override func setUp() {
        sup = PicturesRouter(navigationController: GlobalNavigationViewController(), picturesViewProvider: Provider<PicturesViewController>())
    }
    
}

extension PicturesRouterTest {
    func testPicturesRouter() {
        
        sup.routeTo(target: .detailPicture(picture: Picture(id: 1, photographer: "John", avgColor: "#FFFFFF", src: Source(tiny: "somelink"), isFavorite: false)))
        
        XCTAssertTrue(globalNavController.viewControllers.filter({
            if let _ = $0 as? PictureDetailViewController {
                return true
            }
            return false
        }).count > 0)
                
    }
}
