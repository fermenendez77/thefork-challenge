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
    let persistanceService : RestaurantsPersistance
    
    var restaurants : [Restaurant] = []
    
    //DataBinding
    var hasError : Binding<Bool> = Binding(false)
    var isLoading : Binding<Bool> = Binding(false)
    var isDataLoaded : Binding<Bool> = Binding(false)
    
    var dataCount : Int { restaurants.count }
    var viewModelsCellsBuffer : [String : RestaurantCellViewModel] = [:]
    
    public init(dataFetcher : RestaurantsListDataFetcher = RestaurantsListDataFetcherService(),         persistanceService : RestaurantsPersistance = RestaurantPersistanceService()) {
        self.dataFetcher = dataFetcher
        self.persistanceService = persistanceService
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
                let updatedData = self.updateWithSaved(restaurants: data)
                self.restaurants = updatedData
                self.isDataLoaded.value = !updatedData.isEmpty
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
            let viewModel = RestaurantCellViewModel(with: restaurant,
                                                    persistanceService: persistanceService)
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
    
    private func updateWithSaved(restaurants : [Restaurant]) -> [Restaurant] {
        var restaurants = restaurants
        var savedIds = persistanceService.fetchSaved().map { $0.restaurantID }
        for (index,restaurant) in restaurants.enumerated() {
            if let savedIndex = savedIds.firstIndex(where: { restaurant.uuid == $0 }) {
                restaurants[index].isSaved = true
                savedIds.remove(at: savedIndex)
            }
        }
        return restaurants
    }
}

enum SortProperty {
    case name, rating
}
