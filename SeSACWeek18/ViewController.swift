//
//  ViewController.swift
//  SeSACWeek18
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit

class ViewController: UIViewController {

    let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        api.login()
        api.profile()
    }


}

