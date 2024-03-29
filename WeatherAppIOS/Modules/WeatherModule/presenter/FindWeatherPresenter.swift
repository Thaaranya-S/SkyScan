//
//  HomepagePresenter.swift
//  WeatherAppIOS
//
//  Created by Bilge Çakar on 19.04.2022.
//

import Foundation

class FindWeatherPresenter : ViewToPresenterHomepageProtocol
{
    var homeInteractor: PresenterToInteractorHomepageProtocol?
    
    var homeView: PresenterToViewHomepageProtocol?
    
    func getCurrentWeather(cityName : String) {
        homeInteractor?.getCurrentWeather(cityName : cityName)
    }
    
    func sevenDayWeather(cityName : String) {
        homeInteractor?.sevenDayWeather(cityName : cityName)
    }
    
}

extension FindWeatherPresenter : InteractorToPresenterHomepageProtocol {
    func sendToDataPresenter(weatherInfo : Array<Weather>) {
        homeView?.sendToDataView(weatherInfo: weatherInfo)
    }
    func sendToDataPresenter(weatherInfo: Array<WeatherForecast>) {
        homeView?.sendToDataView(weatherInfo: weatherInfo)
    }
    
}

