
//
//  WeatherDetailsViewController.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/11.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        forecatsDataView()
    }
    
    func forecatsDataView() {
        self.dateLabel?.text = "Date: \(date)"
        self.tempLabel.font = UIFont.systemFont(ofSize: tempLabel.font.pointSize, weight: UIFont.Weight.semibold)
        self.tempLabel.text = "Temperature: \(temp) °C"
        self.humidityLabel.font = UIFont.systemFont(ofSize: tempLabel.font.pointSize, weight: UIFont.Weight.semibold)
        self.humidityLabel.text = "Humidity: \(humidity) g/m3"
        self.windSpeedLabel.font = UIFont.systemFont(ofSize: tempLabel.font.pointSize, weight: UIFont.Weight.semibold)
        self.windSpeedLabel.text = "Windspeed: \(windSpeed) km/h"
        self.statusLabel.font = UIFont.systemFont(ofSize: tempLabel.font.pointSize, weight: UIFont.Weight.semibold)
        if status == true {
            self.statusLabel.text = "Status: safe"
        } else {
            self.statusLabel.text = "Status: unsafe"
        }
    }
    
}


