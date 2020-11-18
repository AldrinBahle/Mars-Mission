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
    
    let repository = WeatherRepositoryImplementation(service: ServiceLayerImplementation())
    
    private lazy var viewModel = WeatherViewModel(view: self, repository: repository)
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
    
    func addRightNavigationBarInfoButton() {
        let button = UIButton(type: .infoDark)
        button.addTarget(self, action: #selector(self.showInfoScreen), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func showInfoScreen() {
        let alert = UIAlertController(title: "Information", message: "Weather Station info: \n\(String(describing: viewModel.post?.weatherStation ?? ""))\n\nLast updated on:\n\(String(describing: viewModel.post?.lastUpdated ?? ""))",
                                      preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel, handler: nil))
    }
    
    func showServerError() {
        let alert = UIAlertController(title: "Oops..!", message: "It looks like the server is not reachable, \nplease try again later.",
                                      preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel, handler: nil))
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
       // vc.title = Date.toString(weatherDetails?.date)
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

extension Date {
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func startOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 1
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func nextDate() -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: self)
        return nextDate ?? Date()
    }
    
    func previousDate() -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
        return previousDate ?? Date()
    }
    
    func addMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeYears(numberOfYears: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .year, value: -numberOfYears, to: self)
        return endDate ?? Date()
    }
    
    func getHumanReadableDayString() -> String {
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        let calendar = Calendar.current.component(.weekday, from: self)
        return weekdays[calendar - 1]
    }
    
    
    func timeSinceDate(fromDate: Date) -> String {
        let earliest = self < fromDate ? self  : fromDate
        let latest = (earliest == self) ? fromDate : self
        
        let components:DateComponents = Calendar.current.dateComponents([.minute,.hour,.day,.weekOfYear,.month,.year,.second], from: earliest, to: latest)
        let year = components.year  ?? 0
        let month = components.month  ?? 0
        let week = components.weekOfYear  ?? 0
        let day = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        
        if year >= 2{
            return "\(year) years ago"
        }else if (year >= 1){
            return "1 year ago"
        }else if (month >= 2) {
            return "\(month) months ago"
        }else if (month >= 1) {
            return "1 month ago"
        }else  if (week >= 2) {
            return "\(week) weeks ago"
        } else if (week >= 1){
            return "1 week ago"
        } else if (day >= 2) {
            return "\(day) days ago"
        } else if (day >= 1){
            return "1 day ago"
        } else if (hours >= 2) {
            return "\(hours) hours ago"
        } else if (hours >= 1){
            return "1 hour ago"
        } else if (minutes >= 2) {
            return "\(minutes) minutes ago"
        } else if (minutes >= 1){
            return "1 minute ago"
        } else if (seconds >= 3) {
            return "\(seconds) seconds ago"
        } else {
            return "Just now"
        }
    }
}


