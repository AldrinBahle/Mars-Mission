//
//  WeatherViewController.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/06.
//

import UIKit

class WeatherViewController: UIViewController, WeatherView {
    
    @IBOutlet weak var weatherView: UIStackView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var background: UIImageView!
    
    private var weatherViewModel: WeatherViewModel?
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init() {
        super.init(nibName: "WeatherViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let service = ServiceLayerImplementation()
        self.weatherViewModel = WeatherViewModel(view: self, repository: WeatherRepositoryImplementation(repository: service))
        collectionView.backgroundColor = UIColor(displayP3Red: 88/255, green: 75/255, blue: 105/255, alpha: 0)
        view.bringSubviewToFront(background)
        weatherViewModel?.configureUI()
        collectionView.register(MainView.self, forCellWithReuseIdentifier: MainView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        view.bringSubviewToFront(loader)
        weatherViewModel?.fetchData()
        showWeatherView()
        hideWeatherView()
    }
    
    func addRightNavigationBarInfoButton() {
        let button = UIButton(type: .infoDark)
        button.addTarget(self, action: #selector(self.showInfoScreen), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func showInfoScreen() {
        let alert = UIAlertController(title: "Information", message: "Weather Station info: \n\(String(describing: weatherViewModel?.post?.weatherStation ?? ""))\n\nLast updated on:\n\(String(describing: convertUCTtoDate(date: weatherViewModel?.post?.lastUpdated ?? "")))", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel, handler: nil))
    }
    
    func showServerError() {
        let alert = UIAlertController(title: "Oops..!", message: "It looks like the server is not reachable," +
                                        "\nplease try again later.", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel, handler: {_ in
            self.hideLoadingIndicator()
        }))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {_ in
            self.weatherViewModel?.fetchData()
        }))
    }
    
    func reloadTableView() {
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func configureTitle(_ title: String) {
        self.title = title
    }
    
    func showWeatherView() {
        self.weatherView?.isHidden = false
    }
    
    func hideWeatherView() {
        self.weatherView?.isHidden = true
    }
    
    func showLoadingIndicator() {
        self.loader?.startAnimating()
        self.loader.isHidden = false
    }
    
    func hideLoadingIndicator() {
        self.loader.isHidden = true
        loader?.stopAnimating()
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherViewModel?.post?.forecasts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainView.identifier, for: indexPath) as! MainView
        guard let weatherData = weatherViewModel?.post?.forecasts?[indexPath.row] else {
            return cell
        }

        cell.dateLabel.text = convertUCTtoDate(date: weatherData.date ?? "")
        cell.dateLabel.font = .italicSystemFont(ofSize: 20)
        cell.dateLabel.textColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weatherDetails = weatherViewModel?.post?.forecasts?[indexPath.row]
        let vc = WeatherDetailsViewController(nibName: "WeatherDetailsViewController", bundle: nil)
        vc.title = convertUCTtoDate(date: weatherDetails?.date ?? "")
        vc.temp = weatherDetails?.temp ?? 0.0
        vc.humidity = weatherDetails?.humidity ?? 0
        vc.windSpeed = weatherDetails?.windSpeed ?? 0
        vc.status = weatherDetails?.safe ?? false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }
}



