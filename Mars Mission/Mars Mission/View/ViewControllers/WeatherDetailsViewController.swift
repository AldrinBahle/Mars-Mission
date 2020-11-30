
//
//  WeatherDetailsViewController.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/11.
//

import UIKit
import SpriteKit

class WeatherDetailsViewController: UIViewController {
    
    private let skView = SKView()
    
    
    
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
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(skView)
        self.view.sendSubviewToBack(skView)
        forecatsDataView()
        skView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = skView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        let leading = skView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        let trailing = skView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 0)
        let bottom = skView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
        initSkScene()
    }
    
    private func initSkScene() {
        let particleScene = ParticleScene(size: CGSize(width: 1080, height: 1920))
        particleScene.scaleMode = .aspectFill
        particleScene.backgroundColor = background
        
        skView.presentScene(particleScene)
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


