//
//  ViewController.swift
//  geeks5
//
//  Created by Баэль Рыспеков on 15/5/23.
//

import UIKit
import SnapKit

class MainView: UIViewController {

    private var controller: MainController!
    
    private lazy var productTableView: UITableView = {
        let view = UITableView()
        view.register(ProductCell.self, forCellReuseIdentifier: "cell" )
        view.dataSource = self
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = MainController(view: self)
        controller.fetchProducts()
        setupSubViews()
    }
    
    
    private func setupSubViews() {
        view.addSubview(productTableView)
        
        productTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
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
        controller?.getProducts().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        cell.fill(product: (controller?.getProducts()[indexPath.row])!)
        return cell
    }
    
}

