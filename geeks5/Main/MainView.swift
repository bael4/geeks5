//
//  ViewController.swift
//  geeks5
//
//  Created by Баэль Рыспеков on 15/5/23.
//

import UIKit
import SnapKit

class MainView: UIViewController {

    
    private var products: [Product] = []
    
    private lazy var productTableView: UITableView = {
        let view = UITableView()
        view.register(ProductCell.self, forCellReuseIdentifier: "cell" )
        view.dataSource = self
        return view
    }()
    
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        fetchData()
        setupSubViews()
    }
  
    func fetchData() {
           Task {
               do {
                   let products = try await NetworkService().fetchProducts()
                   self.products = products
                   DispatchQueue.main.async {
                       self.productTableView.reloadData()
                   }
                   print(products)
               } catch {
                   print(error)
               }
           }
       }

       
    
   
    
    private func setupSubViews() {
        view.addSubview(productTableView)
        
        productTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(100)
          
        }
    }

    
    func reloadProductTableView() {
        DispatchQueue.main.async {
            self.productTableView.reloadData()
        }
    }

}


extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        controller?.getProducts().count ?? 0
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        cell.fill(product: products[indexPath.row])
        return cell
    }
    
}

