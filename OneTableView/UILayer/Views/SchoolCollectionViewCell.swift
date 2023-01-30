//
//  SchoolCollectionViewCell.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 29.01.2023.
//

import Foundation
import UIKit
import SnapKit

class SchoolCollectionViewCell: UICollectionViewCell {
    private var school: School?
    
    private struct Constants {
        static let leftInset: CGFloat = 10
        static let topInset: CGFloat = 10
        static let rightInset: CGFloat = 10
        static let bottomInset: CGFloat = 10
        static let borderWidth: CGFloat = 0.5
        static let imageHeight: CGFloat = 80
        static let cornerRadius: CGFloat = 10.0
        static let wrapperViewInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
        
        private var nameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
            return label
        }()
        
        private var cityLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
           return label
        }()
        
        private var emailLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
            return label
        }()
        
        private var wrapperView: UIView = {
            let view = UIView()
            view.layer.borderColor = UIColor.gray.cgColor
            view.layer.borderWidth = Constants.borderWidth
            view.layer.cornerRadius = Constants.cornerRadius
            return view
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
    
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
    
        private func setupView() {
            backgroundColor = .white
            setupWrapperView()
            setupNameLabel()
            setupCityLabel()
            setupEmailLabel()
        }
    
        private func setupWrapperView() {
            addSubview(wrapperView)
            wrapperView.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(Constants.wrapperViewInsets)
            }
        }
    
        private func setupNameLabel() {
            wrapperView.addSubview(nameLabel)
            nameLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(Constants.leftInset)
                $0.trailing.equalToSuperview().inset(Constants.rightInset)
                $0.top.equalToSuperview().inset(Constants.topInset)
                
            }
        }
    
        private func setupCityLabel() {
            wrapperView.addSubview(cityLabel)
            cityLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(Constants.leftInset)
                $0.trailing.equalToSuperview().inset(Constants.rightInset)
                $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.topInset)
            }
        }
    
        private func setupEmailLabel() {
            wrapperView.addSubview(emailLabel)
            emailLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(Constants.leftInset)
                $0.trailing.equalToSuperview().inset(Constants.rightInset)
                $0.top.equalTo(cityLabel.snp.bottom).offset(Constants.topInset)
                $0.bottom.equalToSuperview().inset(Constants.bottomInset)
            }
        }
    
        func populate(_ school: School) {
            self.school = school
            nameLabel.text = school.schoolName
            cityLabel.text = school.city
            emailLabel.text = school.schoolEmail
        }
    
}
