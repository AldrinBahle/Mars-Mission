//
//  WeatherViewController.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/06.
//

import UIKit

class WeatherViewController: UIViewController, WeatherView {
    
    @IBOutlet weak var weatherView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var safeLabel: UILabel!

    private lazy var viewModel = WeatherViewModel(view: self)
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        tableView.backgroundColor = UIColor.systemBlue
        viewModel.configureUI()
        viewModel.fetchData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
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
}
    
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let weatherDetails = viewModel.post?.forecasts[indexPath.row]
        
        let vc = WeatherDetailsViewController(nibName: "WeatherDetailsViewController", bundle: nil)
        vc.title = weatherDetails?.date
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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


