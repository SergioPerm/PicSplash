//
//  PicturesInteractorTest.swift
//  PicSplashTests
//
//  Created by Sergio Lechini on 06.09.2021.
//

@testable import PicSplash
import SwiftLazy
import XCTest

class PicturesInteractorTest: XCTestCase {

    var sup: PicturesInteractor!
    var presenterMock: PicturesPresenterMock!
    var networkServiceMock: PicturesNetworkingMock!
    var dataSourceMock: PicturesDataSourceMock!

    var somePictures: [Picture] = []
    
    override func setUp() {
        super.setUp()
                
        dataSourceMock = PicturesDataSourceMock()
        networkServiceMock = PicturesNetworkingMock()
        presenterMock = PicturesPresenterMock()
        
        sup = PicturesInteractor(dataSource: dataSourceMock, networkAPI: networkServiceMock)
        sup.presenter = presenterMock
        
        somePictures.append(Picture(id: 1, photographer: "Pol", avgColor: "#FFFFFF", src: Source(tiny: "somelink.jpg"), isFavorite: false))
        somePictures.append(Picture(id: 2, photographer: "Jane", avgColor: "#FFFFFF", src: Source(tiny: "somelink.jpg"), isFavorite: false))
        somePictures.append(Picture(id: 3, photographer: "Kate", avgColor: "#FFFFFF", src: Source(tiny: "somelink.jpg"), isFavorite: false))
        somePictures.append(Picture(id: 4, photographer: "Mark", avgColor: "#FFFFFF", src: Source(tiny: "somelink.jpg"), isFavorite: false))
        somePictures.append(Picture(id: 5, photographer: "Sergio", avgColor: "#FFFFFF", src: Source(tiny: "somelink.jpg"), isFavorite: false))
    }
    
    override func tearDown() {
        sup = nil
        presenterMock = nil
        networkServiceMock = nil
        dataSourceMock = nil
        super.tearDown()
    }
}

extension PicturesInteractorTest {
    func testPicturesBusinessLogic() {
                        
        networkServiceMock.pictureResponse = PicturesResponse(page: 0, perPage: 10, photos: somePictures)
        
        // MARK: loadPictures
        let expectationLoadPictures = expectation(description: "picturesInteractor loadPictures")
        
        presenterMock.completionLoading = {
            expectationLoadPictures.fulfill()
        }
        
        sup.loadPictures()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(somePictures.count, presenterMock.pictures.count)
        
        // MARK: loadPicturesWithPaging
        let expectationLoadPicturesWithPage = expectation(description: "picturesInteractor loadPicturesWithPaging")
        
        presenterMock.completionLoading = {
            expectationLoadPicturesWithPage.fulfill()
        }
        
        sup.loadPicturesWithPaging()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(somePictures.count * 2, presenterMock.pictures.count)
        
        // MARK: loadPicturesByQuery
        let expectationLoadPicturesByQuery = expectation(description: "picturesInteractor loadPicturesByQuery")
        
        presenterMock.completionLoading = {
            expectationLoadPicturesByQuery.fulfill()
        }
        
        sup.loadPicturesByQuery(queryString: "some query")
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(somePictures.count, presenterMock.pictures.count)
        
        // MARK: loadPicturesByQueryWithPaging
        let expectationLoadPicturesByQueryPaging = expectation(description: "picturesInteractor loadPicturesByQueryWithPaging")
        
        presenterMock.completionLoading = {
            expectationLoadPicturesByQueryPaging.fulfill()
        }
        
        sup.loadPicturesByQueryWithPaging(queryString: "some query")
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(somePictures.count * 2, presenterMock.pictures.count)
        
        // MARK: changeFavoriteStatus
        var favoritePic = Picture(id: 5, photographer: "Sergio", avgColor: "#FFFFFF", src: Source(tiny: "somelink.jpg"), isFavorite: true)
        
        sup.changeFavoriteStatus(picture: favoritePic)
        XCTAssertNotNil(dataSourceMock.currentChangeFavorite)
        
        favoritePic.isFavorite = false
        sup.changeFavoriteStatus(picture: favoritePic)
        XCTAssertNil(dataSourceMock.currentChangeFavorite)
    }
}
