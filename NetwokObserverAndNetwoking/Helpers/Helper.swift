//
//  Helper.swift
//  NetwokObserverAndNetwoking
//
//  Created by Prashant on 05/04/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import Foundation
import UIKit
var viewSpinner: UIView? = nil

func isValidEmailId(_ txtEmail: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: txtEmail)
}
func isPassWordValid(text: String) -> Bool{
    let passwordRegEx = "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{8,12})"
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
    return passwordTest.evaluate(with: text)
    
}
func activityStartAnimating() {
    let backgroundView = UIView()
    backgroundView.frame = CGRect.init(x: (UIScreen.main.bounds.size.width/2) - 20, y: (UIScreen.main.bounds.size.height/2), width: 50, height: 50)
    //backgroundView.backgroundColor = UIColor.mainViewColor()
    backgroundView.tag = 475647
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
    activityIndicator.hidesWhenStopped = true
    //activityIndicator.style = UIActivityIndicatorView.Style.gray
    activityIndicator.color = .green//activityColor
    activityIndicator.startAnimating()
    backgroundView.addSubview(activityIndicator)
    UIApplication.shared.windows.first?.addSubview(backgroundView)
}

func activityStopAnimating() {
    if let background = UIApplication.shared.windows.first?.viewWithTag(475647){
        background.removeFromSuperview()
    }
    // self.isUserInteractionEnabled = true
}

//MARK: - Spinner
func addSpinner(forView view:UIView,withText:String) {
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    spinner.frame.size = CGSize(width: 50, height: 50)
    spinner.layer.cornerRadius = 5;
    spinner.layer.masksToBounds = true
    spinner.startAnimating()
    
    let lbl = UILabel()
    lbl.textColor = UIColor.white
    lbl.text = withText
    let font = CGFloat(UIDevice.current.userInterfaceIdiom == .phone ? 16 : 18)
    lbl.font = UIFont(name: "Arimo-Bold", size: CGFloat(font))
    lbl.textAlignment = .center
    lbl.layer.masksToBounds = true
    
    let backgroundView = UIView()
    backgroundView.backgroundColor = UIColor.gray//mainViewColor()
    backgroundView.layer.cornerRadius = 5
    viewSpinner = UIView(frame: view.bounds)
    if let viewSpinner=viewSpinner {
        viewSpinner.addSubview(spinner)
        spinner.center = viewSpinner.center
        lbl.frame.size = CGSize(width: lbl.intrinsicContentSize.width , height: lbl.intrinsicContentSize.height)
        lbl.center = CGPoint.init(x: viewSpinner.center.x, y: viewSpinner.center.y + (spinner.frame.height / 2) + (lbl.frame.height / 2))
        backgroundView.frame = CGRect.init(x: lbl.frame.origin.x - 10, y: spinner.frame.origin.y - 10 , width: lbl.frame.width + 20, height:  spinner.frame.height + lbl.frame.height + 20)
        if !withText.isEmpty{
            viewSpinner.addSubview(backgroundView)
        } else {
            spinner.backgroundColor = UIColor.lightGray//mainViewColor()
        }
        viewSpinner.addSubview(lbl)
        viewSpinner.addSubview(spinner)
        view.addSubview(viewSpinner)
        view.bringSubview(toFront: viewSpinner)
    }
}

func removeSpinner() {
    if viewSpinner != nil {
        viewSpinner?.removeFromSuperview()
        viewSpinner = nil
    }
}

func showAlert(_ withMessage: String) {
    let alertController = UIAlertController(title: nil, message: withMessage, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
}
func getExpenseAmount(_ doubleValue: Double) -> String {
    let formatter = GetNumberFormatter()
    let num :NSNumber = NSNumber(value: doubleValue)
    let totalAmountString = formatter.string(from: num)!
    return totalAmountString as String
}
func GetNumberFormatter() -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    formatter.numberStyle = .decimal
    formatter.locale = NSLocale.init(localeIdentifier: "en_US") as Locale
    return formatter
}
func showMessage(_ message: String, OnParent parent:UIViewController) {
    let alert = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
    parent.present(alert, animated: true, completion: nil)
}
