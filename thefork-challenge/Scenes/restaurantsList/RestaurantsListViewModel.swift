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
    
    
    var restaurants : [Restaurant] = []
    
    //DataBinding
    var hasError : Binding<Bool> = Binding(false)
    var isLoading : Binding<Bool> = Binding(false)
    var isDataLoaded : Binding<Bool> = Binding(false)
    
    var dataCount : Int { restaurants.count }
    var viewModelsCellsBuffer : [String : RestaurantCellViewModel] = [:]
    
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
                self.restaurants = data
                self.isDataLoaded.value = !data.isEmpty
            case .failure(_):
                self.hasError.value = true
                self.isDataLoaded.value = false
            }
        }
    }
    
    public func viewModelCell(for indexPath: IndexPath) -> RestaurantCellViewModel {
        let restaurant = restaurants[indexPath.row]
        if let viewModel = viewModelsCellsBuffer[restaurant.uuid] {
            return viewModel
        } else {
            let viewModel = RestaurantCellViewModel(with: restaurant)
            viewModelsCellsBuffer[restaurant.uuid] = viewModel
            return viewModel
        }
    }
    
    public func sort(by property : SortProperty) {
        switch property {
        case .name:
            self.restaurants = restaurants.sorted(by: \.name, <)
        case .rating:
            self.restaurants = restaurants.sorted(by: \.rating)
        }
        isDataLoaded.value = true
    }
}

enum SortProperty {
    case name, rating
}
