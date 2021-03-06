//
//  WeatherViewModel.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

class WeatherViewModel {
    
    let title = "Mars Weather"
    let repository: WeatherRepository?
    var view: WeatherView
    var post: WeatherDataModel?
    
    
    init(view: WeatherView, repository: WeatherRepository) {
        self.view = view
        self.repository = repository
    }
    
    func configureUI() {
        self.view.configureTitle(title)
        self.view.addRightNavigationBarInfoButton()
        self.view.hideWeatherView()
        self.view.hideLoadingIndicator()
    }
    
    func fetchData() {
        DispatchQueue.main.async {
            self.view.showLoadingIndicator()
        }
        DispatchQueue.global(qos: .background).async {
            self.repository?.fetchData { (result) in
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
            self.view.reloadTableView()
            self.view.hideLoadingIndicator()
            self.view.showWeatherView()
        }
    }
        
    private func handleThatFetchPostFailure(_ error: Error) {
            DispatchQueue.main.async {
                self.view.hideLoadingIndicator()
                self.view.showServerError()
            }
        }
    }
