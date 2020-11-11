//
//  WeatherViewController.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/06.
//

import UIKit

class ListCell: UICollectionViewCell  {
    static let reuseIdentifier = "list-cell-reuse-identifier"
    
    let label = UILabel()
    let accessoryImageView = UIImageView()
    let separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented.")
    }
}

extension ListCell {
    func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        contentView.addSubview(label)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .lightGray
        contentView.addSubview(separatorView)
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(accessoryImageView)
        
        let rightToLeft = effectiveUserInterfaceLayoutDirection == .rightToLeft
        let chevronImageName = rightToLeft ? "chevron.left" : "chevron.right"
        let chevronImage = UIImage(systemName: chevronImageName)
        accessoryImageView.image = chevronImage
        accessoryImageView.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            label.trailingAnchor.constraint(equalTo: accessoryImageView.leadingAnchor, constant: -inset),
            
            accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 13),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
    }
}

class WeatherViewController: UIViewController, WeatherView {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    
    @IBOutlet weak var weatherView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var safeLabel: UILabel!

    private lazy var viewModel = WeatherViewModel(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configureUI()
        viewModel.fetchData()
        configureHierarchy()
        configureDataSource()
        //navigationItem.title = "Mars Mission"
    }

    func configureTitle(_ title: String) {
        self.title = title
    }
    
    func showWeatherView() {
        //self.weatherView.isHidden = false
    }
    
    func hideWeatherView() {
        //self.weatherView.isHidden = true
    }
    
    func showLoadingIndicator() {
        //self.activityIndicator.startAnimating()
        //self.activityIndicator.isHidden = false
    }
    
    func hideLoadingIndicator() {
        //self.activityIndicator.stopAnimating()
        //self.activityIndicator.isHidden = true
    }
    
    func populateWeather(_ date: String, _ temp: Double, _ humidity: Int, _ windSpeed: Int, _ safe: Bool) {
        self.titleLabel.text = title
        self.dateLabel.text = "Date: \(date)"
        self.tempLabel.text = "Temperatue: \(temp)"
        self.humidityLabel.text = "Humidity: \(humidity)"
        self.windSpeedLabel.text = "Wind Speed: \(windSpeed) KM/h"
        if safe == true {
            self.safeLabel.text = "Status: safe"
        } else {
            self.safeLabel.text = "Status: unsafe"
        }
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, IndexPath: IndexPath, Indentifier: Int) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.reuseIdentifier, for: IndexPath) as?
                    ListCell else { fatalError("Cannot create new cell") }
            cell.label.text = "\(Indentifier)"
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(1..<10))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
    

