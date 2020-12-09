//
//  MainView.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/21.
//

import Foundation
import UIKit

class MainView: UICollectionViewCell {
    static let identifier = "Days"
    weak var dateLabel: UILabel!
    let background = hexStringToUIColor(hex: "#0058a9")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = background
        contentView.layer.cornerRadius = 12
        let labelConstraint = UILabel()
        labelConstraint.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelConstraint)
        NSLayoutConstraint.activate([
            labelConstraint.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelConstraint.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelConstraint.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelConstraint.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        dateLabel = labelConstraint
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(ofSize: 20)
        dateLabel.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
