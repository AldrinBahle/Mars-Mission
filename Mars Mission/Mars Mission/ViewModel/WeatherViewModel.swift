//
//  WeatherViewModel.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

class WeatherViewModel {
    let title = "Mars Weather"
    
    let repository = WeatherRepositoryImplementation()
    
    var view: WeatherView
    var post: WeatherDataModel?
    
    
    init(view: WeatherView) {
        self.view = view
    }
    
    func configureUI() {
        self.view.configureTitle(title)
        self.view.hideWeatherView()
        self.view.hideLoadingIndicator()
    }
    
    func fetchData() {
        self.view.showLoadingIndicator()
        DispatchQueue.global(qos: .background).async {
            self.repository.fetchData { (result) in
                switch result {
                case .success(let post):
                    self.handleThatFetchPostSucceeds(post)
                case .failure(let error):
                    self.handleThatFetchPostFailure(error)
                }
            }
        }
    }
    
    private func handleThatFetchPostSucceeds(_ post: WeatherDataModel) {
        DispatchQueue.main.async {
            self.post = post
            self.view.populateWeather(post.forecasts[0].date ?? "",
                                      (post.forecasts[1].temp ?? 0.0),
                                      (post.forecasts[2].hunidity ?? 0.0),
                                      (post.forecasts[3].windspeed ?? 0.0),
                                      post.forecasts[4].safe ?? false)
            self.view.hideLoadingIndicator()
            self.view.showWeatherView()
        }
    }
    
    private func handleThatFetchPostFailure(_ error: Error) {
        DispatchQueue.main.async {
            print(error)
        }
    }
}
