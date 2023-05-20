//
//  MainViewModel.swift
//  geeks5
//
//  Created by Баэль Рыспеков on 20/5/23.
//

import Foundation

class MainViewModel {
    private let networkService = NetworkService()
    
    func fetchProducts() async throws -> [Product] {
        try await networkService.fetchProducts()
    }
}
