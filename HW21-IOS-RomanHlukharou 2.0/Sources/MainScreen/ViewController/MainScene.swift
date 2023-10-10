//
//  ViewController.swift
//  HW21-IOS-RomanHlukharou 2.0
//
//  Created by Роман Глухарев on 8.10.23.
//

import UIKit

class MainScene: UIViewController {

    let urlConstruct = URLConstructor()
    let networkManager = NetworkManager()
    let comicsView = ComicsView()
    
    override func loadView() {
        view = comicsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


}

