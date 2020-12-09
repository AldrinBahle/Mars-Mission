
//
//  WeatherDetailsViewController.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/11.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var date = String()
    var temp = Double()
    var humidity = Int()
    var windSpeed = Int()
    var status = Bool()
    
    let background = hexStringToUIColor(hex: "#3476c5")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecatsDataView()
        stackView.layer.cornerRadius = 12
    }
    
    func forecatsDataView() {
        self.dateLabel?.text = "Date: \(date)"
        self.tempLabel.text = "Temperature: \(temp) °C"
        tempLabel.font = .italicSystemFont(ofSize: 25)
        self.windSpeedLabel.text = "Windspeed: \(windSpeed) km/h"
        windSpeedLabel.font = .italicSystemFont(ofSize: 25)
        self.humidityLabel.text = "Humidity: \(humidity) g/m3"
        humidityLabel.font = .italicSystemFont(ofSize: 25)
        statusLabel.font = .italicSystemFont(ofSize: 25)
        if status == true {
            self.statusLabel.text = "Status: safe"
        } else {
            self.statusLabel.text = "Status: unsafe"
        }
    }
}


