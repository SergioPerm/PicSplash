//
//  PicturesPresenterTest.swift
//  PicSplashTests
//
//  Created by Sergio Lechini on 05.09.2021.
//

@testable import PicSplash
import SwiftLazy
import XCTest

class PicturesPresenterTest: XCTestCase {

    var sup: PicturesPresenter!
    var viewControllerMock: PicturesViewControllerMock!
    var interactorMock: PicturesInteractorMock!
    var routerMock: PicturesRouterMock!
    
    override func setUp() {
        super.setUp()
    
        viewControllerMock = PicturesViewControllerMock()
        interactorMock = PicturesInteractorMock()
        routerMock = PicturesRouterMock()
        
        sup = PicturesPresenter(view: viewControllerMock, router: routerMock, interactor: interactorMock)
        
        interactorMock.presenter = sup
    }

    override func tearDown() {
        sup = nil
        viewControllerMock = nil
        interactorMock = nil
        routerMock = nil
        super.tearDown()
    }
}

extension PicturesPresenterTest {
    func testPicturesPresenter() {
        let pic = Picture(id: 1, photographer: "John", avgColor: "#FFFFFF", src: Source(tiny: "test.jpg"), isFavorite: false)
        let pic2 = Picture(id: 2, photographer: "Kate", avgColor: "#FFFFFF", src: Source(tiny: "test.jpg"), isFavorite: false)
        
        // loadPictures() test
        interactorMock.pictures = [pic]
        sup.loadPictures()
        XCTAssertEqual(interactorMock.pictures.count, viewControllerMock.viewModels.count)
        
        // loadPicturesNewPage test
        interactorMock.picturesForNewPage = [pic2]
        sup.loadPicturesNewPage()
        XCTAssertEqual(interactorMock.pictures.count + interactorMock.picturesForNewPage.count, viewControllerMock.viewModels.count)
        
        // setQuery test
        sup.setQuery(queryString: "some string")
        XCTAssertEqual(interactorMock.pictures.count, viewControllerMock.viewModels.count)
        
        sup.loadPicturesNewPage()
        XCTAssertEqual(interactorMock.pictures.count + interactorMock.picturesForNewPage.count, viewControllerMock.viewModels.count)
    }
}
