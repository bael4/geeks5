//
//  ProductCell.swift
//  geeks5
//
//  Created by Баэль Рыспеков on 15/5/23.
//

import Foundation
import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    static let reuseId = String(describing: ProductCell.self)
    
    private lazy var mainView = UIView()
    
    private lazy var productImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var productTitle: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    private lazy var productDescription: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.numberOfLines = 0
        return label
    }()
    
    private  lazy var productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ){
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        self.addSubview( mainView)
       
        mainView.addSubview(productImage)
        mainView.addSubview(productTitle)
        mainView.addSubview(productDescription)
        mainView.addSubview(productPrice)
        
        mainView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(0)
            make.height.equalTo(300)
        }
        
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        productTitle.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
        }
        
        productDescription.snp.makeConstraints { make in
            make.top.equalTo(productTitle.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
        }
        
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productDescription.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
        }
    }
    
    func fill(product: Product) {
        productImage.kf.setImage(with: URL(string: product.thumbnail))
        productTitle.text = product.title
        productDescription.text = product.description
        productPrice.text = "\(product.price)"
    }
}
