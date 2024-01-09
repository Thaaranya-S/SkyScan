//
//  View+Extension.swift
//  SkyScan
//
//  Created by Thaaranya Subramani on 31/12/23.
//

import Foundation
import UIKit

//MARK: - Gradient View - Create
@IBDesignable
public class GradientView: UIView {
    private func createGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    private var gradient: CAGradientLayer?
    
    @IBInspectable
    public var color1: UIColor? {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable
    public var color2: UIColor? {
        didSet {
            updateColors()
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        gradient = createGradient()
        updateColors()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        gradient = createGradient()
        updateColors()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        gradient?.frame = bounds
    }
    
    private func updateColors() {
        guard
            let color1 = color1,
            let color2 = color2
        else {
            return
        }
        
        gradient?.colors = [color1.cgColor, color2.cgColor]
    }
}

class RoundedView : UIView{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        roundedView()
    }
    
    func roundedView() {
        self.contentMode = .scaleToFill
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }
}

//MARK: - Gradient View
extension UIView{
    
    func addBlackGradientLayerInForeground(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
    
    func addBlackGradientLayerInBackground(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.insertSublayer(gradient, at: 0)
    }
}

//MARK: - Gradient Layer
extension UIView {
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
        
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        //gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradient,at: 0)
    }
    
}


//MARK: - Load Nib
extension UIView {
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}


//MARK: - Horizontal Gradient
extension UIView {
    func insertHorizontalGradient(_ color1: UIColor, _ color2: UIColor) -> GradientView {
        let gradientView = GradientView(frame: bounds)
        gradientView.color1 = color1
        gradientView.color2 = color2
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.insertSubview(gradientView, at: 0)
        return gradientView
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}


extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        let dx = 5.0
        let rect = bounds.insetBy(dx: dx, dy: dx)
        layer.shadowPath = UIBezierPath(rect: rect).cgPath
        //        layer.shouldRasterize = true
        //        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func roundedCornerView() {
        self.contentMode = .scaleToFill
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
        
    }
    
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
}

extension UIView {
    //cornerradius for particular view corners
    func corners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func applyShadow() {
        var shadows = UIView()
        shadows.frame = self.frame
        shadows.clipsToBounds = false
        self.addSubview(shadows)
        
        let shadowPath0 = UIBezierPath(roundedRect: self.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0.851, green: 0.867, blue: 0.91, alpha: 0.25).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 40
        layer0.shadowOffset = CGSize(width: 0, height: 0)
        layer0.bounds = self.bounds
        layer0.position = self.center
        shadows.layer.addSublayer(layer0)
    }
    
    func addProfileShadow(_ shadowColor:UIColor? = UIColor.black) {
        self.layer.masksToBounds = false;
        self.layer.cornerRadius = self.bounds.height/2; // if you like rounded corners
        self.layer.shadowOffset = CGSize(width: 0, height: 3);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowColor = shadowColor?.cgColor
    }
    
}


public extension UIView {
    
    /// Border color of view; also inspectable from Storyboard.
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    ///Border width of view; also inspectable from Storyboard.
    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    
    /// Fade in view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    /// Fade out view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: completion)
    }
    
    /// Load view from nib.
    ///
    /// - Parameters:
    ///   - name: nib name.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: optional UIView (if applicable).
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    /// Remove all subviews in view.
    func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    /// Remove all gesture recognizers from view.
    func removeGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }
    
    ///  Attaches gesture recognizers to the view. Attaching gesture recognizers to a view defines the scope of the represented gesture, causing it to receive touches hit-tested to that view and all of its subviews. The view establishes a strong reference to the gesture recognizers.
    ///
    /// - Parameter gestureRecognizers: The array of gesture recognizers to be added to the view.
    func addGestureRecognizers(_ gestureRecognizers: [UIGestureRecognizer]) {
        for recognizer in gestureRecognizers {
            addGestureRecognizer(recognizer)
        }
    }
    
    ///  Detaches gesture recognizers from the receiving view. This method releases gestureRecognizers in addition to detaching them from the view.
    ///
    /// - Parameter gestureRecognizers: The array of gesture recognizers to be removed from the view.
    func removeGestureRecognizers(_ gestureRecognizers: [UIGestureRecognizer]) {
        for recognizer in gestureRecognizers {
            removeGestureRecognizer(recognizer)
        }
    }
    
}

//LoadingNib
extension UIView {
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
        else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
}

extension UIView {
    func fadeIn() {
        UIView.animate(withDuration: 0.8, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.8, delay: 0.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
}
extension UIViewController {
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showToast(message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
class Gradient: UIView{
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [#colorLiteral(red: 0.381236136, green: 0.4572219849, blue: 0.8372017145, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.7333333333, blue: 0.568627451, alpha: 1).cgColor]
        layer.addSublayer(gradient)
    }
    required init?(coder: NSCoder){
        fatalError()
    }
}

extension UIViewController {
    func popViewController(duration: Double = 0.0){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension UIViewController {
    func showAlert(title: String, msg: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}
