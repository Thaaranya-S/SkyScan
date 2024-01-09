//
//  HomepageRouter.swift
//  WeatherAppIOS
//
//  Created by Bilge Çakar on 19.04.2022.
//

import Foundation
import UIKit

class FindWeatherRouter : PresenterToRouterHomepageProtocol {
    
    var view:UIViewController?

    static func createModule(ref: FindWeatherViewController) {
        let presenter = FindWeatherPresenter()
        ref.homePresenterObject = presenter
        ref.homePresenterObject?.homeView = ref
        ref.homePresenterObject?.homeInteractor = FindWeatherInteractor()
        ref.homePresenterObject?.homeInteractor?.homePresenter = presenter
    }
    
    class func getMainView() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FindWeatherViewController")
       return viewController
        
    }
}
