//
//  RestaurantsListDataFetcher.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import Foundation

protocol RestaurantsListDataFetcher {
    
    var networkService : NetworkService { get set }
    func fetchData(completionHandler: @escaping (Result<[Restaurant],
                                                 Error>) -> Void)
}

class RestaurantsListDataFetcherService : RestaurantsListDataFetcher  {
    
    let url = URL(string: "https://alanflament.github.io/TFTest/test.json")!
    
    var networkService : NetworkService
    
    public init(networkService : NetworkService = NetworkServiceImpl() ) {
        self.networkService = networkService
    }
    
    func fetchData(completionHandler: @escaping (Result<[Restaurant],
                                                 Error>) -> Void) {
        networkService.fetchData(from: url,
                                 returnType: RestaurantsResponse.self) { result in
            switch result {
            case .success(let response):
                completionHandler(.success(response.data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

