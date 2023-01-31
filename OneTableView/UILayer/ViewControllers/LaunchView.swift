//
//  LaunchView.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 31.01.2023.
//

import Foundation
import UIKit
import SnapKit

class LaunchView: UIViewController{
    
    private var centerImage =  UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(centerImage)
        setupImageView()
        setupConstraints()
        self.delay(2) {
            self.navigationController?.setViewControllers([ViewController()], animated: true)
        }
    }
    
    func setupImageView() {
        centerImage.contentMode = .scaleToFill
        centerImage.image = UIImage(named: "NYC")
    }
    
    func setupConstraints() {
        centerImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(400)
            $0.height.equalTo(400)
        }
    }
    
    func delay(_ delay: Double, closure: @escaping () -> ()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    
}
