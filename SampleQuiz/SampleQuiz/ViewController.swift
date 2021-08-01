//
//  ViewController.swift
//  SampleQuiz
//
//  Created by muffin man on 2021/07/21.
//  github Test

import UIKit

class ViewController: UIViewController {
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 枠線の太さ
        startButton.layer.borderWidth = 2
        // 枠線の色
        startButton.layer.borderColor = UIColor.black.cgColor
    }


}

