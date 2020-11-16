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
    
    
    private lazy var viewModel = WeatherViewModel(view: self)
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.systemTeal
        viewModel.configureUI()
        view.addSubview(tableView)
        view.bringSubviewToFront(loader)
        viewModel.fetchData()
        tableView.delegate = self
        tableView.dataSource = self
        showWeatherView()
        hideWeatherView()
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let weatherDetails = viewModel.post?.forecasts[indexPath.row]
        
        let vc = WeatherDetailsViewController(nibName: "WeatherDetailsViewController", bundle: nil)
        vc.title = weatherDetails?.date
        vc.temp = weatherDetails?.temp ?? 0.0
        vc.humidity = weatherDetails?.humidity ?? 0
        vc.windSpeed = weatherDetails?.windSpeed ?? 0
        vc.status = weatherDetails?.safe ?? false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection secion: Int) -> Int {
        return viewModel.post?.forecasts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.isOpaque = false
        guard let forecast = viewModel.post?.forecasts[indexPath.row] else {
            return cell
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let str = dateFormatter.date(from: forecast.date ?? "")
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let date = dateFormatter.string(from: str!)
        let finalVal = date.components(separatedBy: "-")
        cell.textLabel?.text = "\(finalVal.first ?? "" )"
        return cell
    }
}


