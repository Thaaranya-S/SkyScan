//
//  HomepageInteractor.swift
//  WeatherAppIOS
//
//  Created by Bilge Çakar on 19.04.2022.
//

import Foundation
import UIKit

class FindWeatherInteractor : PresenterToInteractorHomepageProtocol {
    
    var homePresenter: InteractorToPresenterHomepageProtocol?
    
    func getCurrentWeather(cityName : String) {
        
        let url = URL(string: "https://api.weatherbit.io/v2.0/current?city=\(cityName)&key=86ecc493bae940aea4e9fb13ccac1c3f")!
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if error != nil || data == nil {
                print("Error")
                return
            }
            do {
                let answer = try JSONDecoder().decode(WeatherResponse.self, from: data!)
                var list = [Weather]()
                if let answerList = answer.data {
                    list = answerList
                }
                self.homePresenter?.sendToDataPresenter(weatherInfo: list)
            }
            catch {
                print("JSON ERROR : \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func sevenDayWeather(cityName : String) {
        
        let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/daily?city=\(cityName)&key=86ecc493bae940aea4e9fb13ccac1c3f")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Error")
                return
            }
            do {
                let answer = try JSONDecoder().decode(WeatherForecastResponse.self, from: data!)
                var listTwo = [WeatherForecast]()
                if let answerWeatherList = answer.data {
                    listTwo = answerWeatherList
                }
                self.homePresenter?.sendToDataPresenter(weatherInfo: listTwo)
            }
            catch {
                print("JSON ERROR : \(error.localizedDescription)")
            }
        }.resume()
    }
}

