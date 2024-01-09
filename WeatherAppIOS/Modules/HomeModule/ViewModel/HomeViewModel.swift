//
//  HomeViewModel.swift
//  SkyScan
//
//  Created by Thaaranya Subramani on 08/01/24.
//

import Foundation

class HomeViewModel: NSObject {
    
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
            }
            catch {
                print("JSON ERROR : \(error.localizedDescription)")
            }
        }.resume()
    }
}
