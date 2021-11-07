//
//  thefork_challengeTests.swift
//  thefork-challengeTests
//
//  Created by Fernando Menendez on 05/11/2021.
//

import XCTest
@testable import thefork_challenge

class RestaurantsViewModelTests: XCTestCase {


    func testDataFetchingWithError() throws {
        let dataFetcher = MockedDataFetcher()
        dataFetcher.error = true
        let viewModel = RestaurantsListViewModel(dataFetcher: dataFetcher)
        viewModel.fetchData()
        XCTAssertTrue(viewModel.hasError.value)
    }
    
    func testDataFetchingSuccess() throws {
        let dataFetcher = MockedDataFetcher()
        dataFetcher.error = false
        let viewModel = RestaurantsListViewModel(dataFetcher: dataFetcher)
        XCTAssertFalse(viewModel.isDataLoaded.value)
        viewModel.fetchData()
        XCTAssertTrue(viewModel.isDataLoaded.value)
        XCTAssertTrue(viewModel.restaurants.count > 0)
    }

}

class MockedDataFetcher : RestaurantsListDataFetcher {
    
    var networkService: NetworkService = NetworkServiceImpl()
    var error = false
    
    func fetchData(completionHandler: @escaping (Result<[Restaurant], Error>) -> Void) {
        if error {
            let error = NSError(domain: "domain", code: 100, userInfo: [:])
            completionHandler(.failure(error))
        } else {
            let decoder = JSONDecoder()
            let data = try! decoder.decode(RestaurantsResponse.self, from: restaurantsData)
            let restaurants = data.data
            completionHandler(.success(restaurants))
        }
    }
}
