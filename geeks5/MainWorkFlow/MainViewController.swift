//
//  ViewController.swift
//  geeks5
//
//  Created by Баэль Рыспеков on 15/5/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private var products: [Product] = []
    
    private lazy var productTableView: UITableView = {
        let view = UITableView()
        view.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId )
        view.dataSource = self
        return view
    }()
    
    private let viewModel: MainViewModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = MainViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = MainViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        fetchData()
        setupSubViews()
    }
  
    func fetchData() {
        Task {
            do {
                let products = try await viewModel.fetchProducts()
                self.products = products
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
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
}

extension MainViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        products.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductCell.reuseId,
            for: indexPath
        ) as! ProductCell
        cell.fill(product: products[indexPath.row])
        return cell
    }
}

