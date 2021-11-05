//
//  RestaurantsListViewModel.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import Foundation

class RestaurantsListViewModel {
    
    //Dependencies
    let dataFetcher : RestaurantsListDataFetcher
    
    //Data Binding
    var restaurants : Binding<[Restaurant]> = Binding([])
    var hasError : Binding<Bool> = Binding(false)
    var isLoading : Binding<Bool> = Binding(false)
    
    var dataCount : Int { restaurants.value.count }
    
    public init(dataFetcher : RestaurantsListDataFetcher = RestaurantsListDataFetcherService()) {
        self.dataFetcher = dataFetcher
    }
    
    public func fetchData() {
        isLoading.value = true
        dataFetcher.fetchData { [weak self] result in
            guard let self = self else {
                return
            }
            self.isLoading.value = false
            switch result {
            case .success(let data):
                self.restaurants.value = data
            case .failure(_):
                self.hasError.value = true
            }
        }
    }
}
