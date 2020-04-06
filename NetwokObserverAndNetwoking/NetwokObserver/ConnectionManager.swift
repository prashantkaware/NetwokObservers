//
//  ConnectionManager.swift
//  NetwokObserverAndNetwoking
//
//  Created by Prashant on 05/04/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import Foundation
import UIKit
class ConnectionManager {
    var isConnectionBreak = false
    static let sharedInstance = ConnectionManager()
    public var reachability : Reachability!

    func observeReachability(){
        self.reachability = Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        }
        catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular:
            print("Network available via Cellular Data.")
            //uploadData()
            if isConnectionBreak{
                DispatchQueue.main.async {[weak self] in
                    //guard let sSelf = self else {return}
                    if let topController = UIApplication.topViewController() {
                        sSelf.isConnectionBreak = false
                        print(topController)
                        topController.navigationController?.popViewController(animated: true)
                    }
                }

            }
            break
        case .wifi:
            if isConnectionBreak{
            if let topController = UIApplication.topViewController() {
                DispatchQueue.main.async {[weak self] in
                    guard let sSelf = self else {return}
                    if let topController = UIApplication.topViewController() {
                        print(topController)
                        sSelf.isConnectionBreak = false
                        topController.navigationController?.popViewController(animated: true)
                    }
                }
            }
            }
            print("Network available via WiFi.")
            break
        case .none:
            if let topController = UIApplication.topViewController() {
                print(topController)
                DispatchQueue.main.async {[weak self] in
                    guard let sSelf = self else {return}
                    if let topController = UIApplication.topViewController() {
                        sSelf.isConnectionBreak = true
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let noNetwokVC = storyBoard.instantiateViewController(withIdentifier: "NoNetwokViewController") as! NoNetwokViewController
                        topController.navigationController?.pushViewController(noNetwokVC, animated: true)
                    }
                }

            }
            print("Network is not available.")
            break
        }
    }

}
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

