//
//  TodoCell.swift
//  WorkWithRestAPI
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import UIKit
import SDWebImage

final class CoinCell: UITableViewCell {
    static let id = String(describing: type(of: CoinCell.self))
    private let idLabel = UILabel()
    private var iconView = UIImageView()
    private let iconName = UILabel()
    private let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        priceLabel.textAlignment = .right

        idLabel.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconName.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(idLabel)
        self.addSubview(iconView)
        self.addSubview(iconName)
        self.addSubview(priceLabel)
        
        makeAutoLayout()
    }
    
    private func makeAutoLayout() {
        NSLayoutConstraint.activate([
            idLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            idLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            iconView.leftAnchor.constraint(equalTo: idLabel.rightAnchor, constant: 15),
            iconView.widthAnchor.constraint(equalToConstant: self.frame.height - 10),
            iconView.heightAnchor.constraint(equalToConstant: self.frame.height - 10),
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            iconName.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 15),
            iconName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            priceLabel.widthAnchor.constraint(equalToConstant: self.frame.width / 2),
            priceLabel.heightAnchor.constraint(equalToConstant: self.frame.height - 10),
            priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func configurationForItems(coin: Coin) {
        idLabel.text = "\(coin.rank!)"
        iconView.sd_setImage(with: URL(string: coin.icon ?? ""))
        iconName.text = coin.id
        priceLabel.text = "\(coin.price!)"
    }
}
