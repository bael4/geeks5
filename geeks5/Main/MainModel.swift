//
//  MainModel.swift
//  geeks5
//
//  Created by Баэль Рыспеков on 16/5/23.
//

import Foundation



class MainModel {
    
    private weak var controller: MainController!
    
    private var networkService = NetworkService()
    
    private var products: [Product] = []
    
    init(controller: MainController!) {
        self.controller = controller
    }
    
    func fetchProducts() {
        networkService.fetchProducts { result in
            switch result {
            case .success(let product):
                self.products = product
            case .failure(let error):
                print("\(error)")
            }
            
            self.controller.tableViewReloaded()
        }
    }
    
    func getProducts() -> [Product] {products}
}
