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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configureUI()
        viewModel.fetchData()
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
        self.titleLabel.text = "Temperatue: \(temp)"
        self.humidityLabel.text = "Humidity: \(humidity)"
        self.windSpeedLabel.text = "Wind Speed: \(windSpeed) KM/h"
        if safe == true {
            self.safeLabel.text = "Status: safe"
        } else {
            self.safeLabel.text = "Status: unsafe"
        }
    }
}
    

