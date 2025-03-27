//
//  NetworkManagerTests.swift
//  CatgifTests
//
//  Created by Jor . on 26/03/2025.
//

import XCTest
@testable import Catgif
final class NetworkManagerTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    /*
     Test when the api is successful
     fetch function will return expected data, reading data from locally saved json
     */
    func test_fetch_CatBreed_list_when_APIResponse_is_successful() async throws {
        
        //Reading from local Json file Data
        let bundle = Bundle(for: NetworkManagerTests.self)
        guard let path = bundle.url(forResource: "CatBreedSampleTestFile", withExtension: "json")
            else{ return }
        
        let data = try? Data(contentsOf: path)
        NetworkingMock.data = data
        
        let networkManager = NetworkManager(urlSession: NetworkingMock())
        let url = URL(string: "http://www.test.com")!
        let actualData = try! await networkManager.getDataFromAPI(url: url)
        XCTAssertEqual(actualData, data)
    }
    
    /*
     Test when the api is successful but the json parsing fails
     fetch function will return jsonParsingFailed exception
     */
    func test_fetch_CatBreed_list_when__json_parsing_fails() async{
        let networkManager = NetworkManager(urlSession: NetworkingMock())
        let url = URL(string: "http://www.test.com")!
        
        do {
            let _ = try await networkManager.getDataFromAPI(url: url)
        }catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.dataNotFound)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
