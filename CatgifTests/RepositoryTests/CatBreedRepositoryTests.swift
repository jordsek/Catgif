//
//  CatBreedRepositoryTests.swift
//  CatgifTests
//
//  Created by Jor . on 26/03/2025.
//

import XCTest
@testable import Catgif
final class CatBreedRepositoryTests: XCTestCase {

    var fakeNetworkManager: FakeNetworkManager!
    var catBreedRepositoryImplementation: CatBreedRepositoryImplementation!
    
    override func setUpWithError() throws {
        fakeNetworkManager = FakeNetworkManager()
    catBreedRepositoryImplementation = CatBreedRepositoryImplementation(networkmanager: fakeNetworkManager)
    }

    override func tearDownWithError() throws {
        catBreedRepositoryImplementation = nil
    }

    //Test when API passes the breed array will return data
    func test_fetchBreeds_whenAPIResponseSuccess_returnsBreeds() async throws {
         
        let arr = try! await catBreedRepositoryImplementation.getBreedData(url: URL(string: "CatBreedSampleTestFile")!)
        XCTAssertNotNil(arr)
        XCTAssertTrue(arr.count > 0)
        XCTAssertEqual(arr[0].id, "abys")
        XCTAssertEqual(arr[0].name, "Abyssinian")
        XCTAssertEqual(arr[0].origin, "Egypt")
    }
    
    //Test when Api fails
    func test_fetchBreeds_whenAPIResponseFail_returnsNil() async throws {
        let arr = try? await catBreedRepositoryImplementation.getBreedData(url: URL(string: "CatBreedNoDataSampleTestFile")!)
        XCTAssertNil(arr)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
