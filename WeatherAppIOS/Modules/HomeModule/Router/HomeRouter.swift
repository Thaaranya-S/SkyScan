//
//  HomeRouter.swift
//  SkyScan
//
//  Created by Thaaranya Subramani on 08/01/24.
//

import Foundation
import UIKit

class HomeRouter {
    
    var view:UIViewController?
    
    class func getMainView() -> UIViewController {
        guard let vc = getStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return UIViewController() }
        let model = HomeViewModel()
        let router = HomeRouter()
        vc.homeViewModel = model
        router.view = vc
        return vc
        
    }
    
    static var getStoryBoard: UIStoryboard{
        return UIStoryboard(name:"HomeViewController",bundle: nil)
    }
}
