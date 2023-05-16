//
//  MainController.swift
//  geeks5
//
//  Created by Баэль Рыспеков on 16/5/23.
//

import Foundation




class MainController {
    private weak var view: MainView!
    
    private var model: MainModel?
    
    init(view: MainView) {
        self.view = view
        self.model = MainModel(controller: self)
    }
    
    func fetchProducts() {
        model?.fetchProducts()
    }
    
    func getProducts() -> [Product] {
        let products = model?.getProducts()
        return products!
    }
    
    func tableViewReloaded() {
        view.reloadProductTableView()
    }
    
}
