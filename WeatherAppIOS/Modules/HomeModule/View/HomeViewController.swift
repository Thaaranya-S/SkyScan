//
//  HomeViewController.swift
//  SkyScan
//
//  Created by Thaaranya Subramani on 30/12/23.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var viewTapForMore: UIView!
    @IBOutlet weak var viewLiveWeatherBg: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //Outlets - WeatherValues
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var windyLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var homeViewModel: HomeViewModel?
    var router: HomeRouter!
    var weatherList = [Weather]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
        getCurrentWeather(cityName: "Tokyo")
        getCurrentLocation()
        currentDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCurrentLocation()
    }
    
    func setupView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{
            self.viewLiveWeatherBg.corners(corners: .topLeft, radius: 40)
        })
    }
    
    func setupGesture() {
        let tapGestureTapForMore = UITapGestureRecognizer.init(target: self, action: #selector(self.moveToWeatherLogsScreen))
        self.viewTapForMore.addGestureRecognizer(tapGestureTapForMore)
    }
    
    @objc func moveToWeatherLogsScreen() {
        let vc = FindWeatherRouter.getMainView()
        self.present(vc, animated: true)
    }
    
    func currentDate() {
        let currentDate = Date()
        let formatter = DateFormatter()
        
        // For displaying the date in a specific format (e.g., year-month-day)
        formatter.dateFormat = "dd"
        let dateString = formatter.string(from: currentDate)
        labelDate.text = "\(dateString)'"
        
        // For getting the name of the day (e.g., Monday, Tuesday, etc.)
        formatter.dateFormat = "EEE"
        let dayOfWeek = formatter.string(from: currentDate)
        labelDay.text = dayOfWeek.uppercased()
        
        // For getting the current hours
        formatter.dateFormat = "HH"
        let formattedTime = formatter.string(from: currentDate)
        let hour = Int(formattedTime)!
        
        switch hour {
        case 5...18:
            self.backgroundImage.image = UIImage(named:"Daytime")
        case 18...24:
            self.backgroundImage.image = UIImage(named: "NightDay")
        default:
            self.backgroundImage.image = UIImage(named:"NightDay")
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            if let location = locations.first {
                self.getCountryAndCity(location: location)
            }
        }
    }
    
    func getCountryAndCity(location: CLLocation) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error reverse geocoding: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                let country = placemark.country ?? "Unknown Country"
                let city = placemark.locality ?? "Unknown City"
                
                self.labelCountry.text = country
                self.getCurrentWeather(cityName: city)
            }
        }
    }
    
    func getCurrentLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
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
                print("please print\(list)")
                self.updateDataToView(weatherInfo: list)
            }
            catch {
                print("JSON ERROR : \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func updateDataToView(weatherInfo: Array<Weather>) {
        self.weatherList = weatherInfo
        DispatchQueue.main.async {
            self.labelCity.text = self.weatherList[0].city_name
            self.labelWeather.text = self.weatherList[0].weather?.description
            self.labelTemp.text = "\(self.weatherList[0].temp ?? 0.0)°"
            self.sunsetLabel.text = self.weatherList[0].sunrise!
            self.windyLabel.text = String(format: "%0.2f", self.weatherList[0].wind_spd!) + "m/s"
            self.cloudLabel.text = "\(self.weatherList[0].clouds!) %"
        }
    }
}

