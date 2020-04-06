//
//  ViewController.swift
//  NetwokObserverAndNetwoking
//
//  Created by Prashant on 05/04/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickButtonGoToSecondVC(_ sender: UIButton) {
        let seconVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(seconVC, animated: true)
    }
    
}

