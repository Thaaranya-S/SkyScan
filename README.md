# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Usage](#usage)
4. [Arhitecture](#arhitecture)
5. [Structure](#structure)
6. [Dependencies](#dependencies)
7. [Design](#design)
8. [API](#api)

# SkyScan
A simple weather app that shows weather information based on the location built with Xcode.

# Description
<p>SkyScan will getting the persmission from user for location.<br>
Then it will show updated details like user current location, current weather, Date.<br> 
Finally in details screen User can enter the mentioned City name.<br>
With the base of city, upcoming days of weather, temperature, wind will displayed </p>

# Getting started
<p>
1. Make sure you have the Xcode version 14.0 or above installed on your computer.<br>
2. Download the SkyScan project files from the repository.<br>
3. Open the project files in Xcode.<br>
4. Review the code and make sure you understand what it does.<br>
5. Run the active scheme.<br>
You should see the lootie animation that leads you to the Home Screen with alert that ask permission for user location.<br>

# Usage
In order to see the weather of your current location or your loved location, you must install the SkyScan application.

# Architecture
* SkyScan project is implemented using the both <strong>Model-View-ViewModel (MVC)</strong> and <strong>View-Interactor-Presenter-Entity-Router(VIPER)</strong>architecture pattern.
* Home module is implemented using the <strong>Model-View-ViewModel (MVC)</strong> architecture pattern.
* Model has any necessary data or business logic needed to generate weather and locaiton.
* View is responsible for displaying the weather and response to the user, user input or interactions.
* ViewModel handles Data Presentation, State Management, Data Binding.
How to create a new screen?<br>
The router serves for navigation. In order to present ViewController, Router present method must be called.<br>
Below is a code snippet with an example.<br>

```
let vc = WeatherLogsRouter.getMainView()
self.present(vc, animated: true)

class WeatherLogsRouter {
    
    var view: UIViewController?
    
    class func getMainView() -> UIViewController {
        guard let vc = getStoryBoard.instantiateViewController(withIdentifier: "WeatherLogsViewController") as? WeatherLogsViewController else { return UIViewController() }
        return vc
    }
    
    static var getStoryBoard: UIStoryboard {
        //User your storyboard name
        return UIStoryboard(name:"WeatherLogsViewController",bundle: nil)
    }
}

```

* FindWeather module is implemented using the <strong>View-Interactor-Presenter-Entity-Router (VIPER)</strong> architecture pattern.
* View represents the user interface (UI) elements and their interactions.
* Interactor contains the application's business logic.
* Presenter acts as an intermediary between the View and the Interactor.
* Entities represent the core data structures and business objects of the application.
* Router handles navigation and routing between different screens or modules of the app.

# Structure 
* "Module": The source code files for a specific module. Files within a module folder are organized into subfolders, such as "HomeModule" or "WeatherModule".
* "HomeModule": The source code files for a specific module. It holds the MVVM structured Home screen files.
* "WeatherModule": The source code files for a specific module. It holds the VIPER structured find Weatherfiles.
* "Cities": It has .csv file, that has collection of cities for the findWeather.
* "Animations": As name define it has animation file of Locaiton, cloud and launch.
* "Fonts": It has custom fonts of AdventPro and Rubik family
* "CustomClass": Custom and resuable file for errors and UIView. 
* "Extensions": The Module that holds the extension features or funcions on elements like UIView, UIViewControllers, UIColors.

# Dependencies
[CocoaPods](https://cocoapods.org) is used as a dependency manager.
List of dependencies: 
* Package Dependency - Lottie : Used for the good animation while launching the application
* Package Dependency - ViewAnimation : Used for smooth animation for internal screens.

# Design 
* Design tool user for SkyScan [Dribbble]
* All of the design is and must be only in one tool and currently it is Dribbble.<br>
* Colors in the Dribbble must have same name as colors in Xcode project.<br> 
* Basic UI elements are defined.

# API 
* Open API is used to get the weather details that displayed in SkyScan
* Accessibility of Open Weather API mentioned [Weatherbit](https://www.weatherbit.io/) 
* One call API used to get response for Weather History and documentaion of One call Open API [OneCall](https://openweathermap.org/api/one-call-3#current) 

//Important Note:
* Allow the Locaiton access to see your active weather details
* The Open weather [Weatherbit](https://www.weatherbit.io/) API will work only for 30 days as per the documentaion.
* <strong> If location is not getting updated, create new API key and replace with old key</strong> (old key = 86ecc493bae940aea4e9fb13ccac1c3f)

