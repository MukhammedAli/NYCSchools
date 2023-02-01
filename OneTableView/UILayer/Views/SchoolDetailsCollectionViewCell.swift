//
//  SchoolDetailsCollectionViewCell.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 31.01.2023.
//

import Foundation
import UIKit

class SchoolDetailsCollectionViewCell: UICollectionViewCell {

    private var school: School?

    private struct Constants {
        static let leftInset: CGFloat = 10
        static let topInset: CGFloat = 10
        static let rightInset: CGFloat = 10
        static let bottomInset: CGFloat = 10
        static let borderWidth: CGFloat = 0.5
        static let cornerRadius: CGFloat = 10.0
        static let wrapperViewInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        static let spacing: CGFloat = 5.0
    }

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.numberOfLines = 0
        return label
    }()

    private var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = "School Address"
        label.numberOfLines = 0
        return label
    }()

    private var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        return label
    }()
    
    private var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = "School email"
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        return label
    }()
    
    private var phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = "Phone title"
        return label
    }()
    
    private var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        return label
    }()
    
    private var academicOpportunitiesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        label.text = "Phone title"
        return label
    }()
    
    private var academicOpportunitiesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private var gradesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        label.text = "Grades Title"
        return label
    }()
    
    private var gradesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private var websiteTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        label.text = "Grades Title"
        return label
    }()
    
    private var websiteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        return label
    }()
    
    private var wrapperView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.spacing
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupWrapperView() {
        addSubview(wrapperView)
        wrapperView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.wrapperViewInsets)
        }
    }
    
    private func setupViews() {
        backgroundColor = .white
        setupWrapperView()
        setupStackView()
    }
    
    private func setupStackView() {
        wrapperView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.topInset)
            $0.left.equalToSuperview().inset(Constants.leftInset)
            $0.right.equalToSuperview().inset(Constants.rightInset)
            $0.bottom.equalToSuperview().inset(Constants.bottomInset)
        }
        
        stackView.addArrangedSubview(nameLabel)
        
        stackView.addArrangedSubview(addressTitleLabel)
        stackView.addArrangedSubview(addressLabel)
        
        stackView.addArrangedSubview(emailTitleLabel)
        stackView.addArrangedSubview(emailLabel)
        
        stackView.addArrangedSubview(phoneTitleLabel)
        stackView.addArrangedSubview(phoneLabel)
        
        stackView.addArrangedSubview(academicOpportunitiesTitleLabel)
        stackView.addArrangedSubview(academicOpportunitiesLabel)
        
        stackView.addArrangedSubview(gradesTitleLabel)
        stackView.addArrangedSubview(gradesLabel)
        
        stackView.addArrangedSubview(websiteTitleLabel)
        stackView.addArrangedSubview(websiteLabel)
        
        
        
    }
    
    func populate(school: School) {
        self.school = school
        nameLabel.text = school.schoolName
        
        var fullAddress = ""
        var addressComponents: [String] = []
        
        if let city = school.city {
            addressComponents.append(city)
        }
        
        if let addressLine = school.primaryAddressLine {
            addressComponents.append(addressLine)
        }
        
        if let zipCode = school.zip {
            addressComponents.append(zipCode)
        }
        
        fullAddress = addressComponents.joined(separator: ", ")
        
        addressLabel.text = fullAddress
        
        emailLabel.text = school.schoolEmail ?? ""
        phoneLabel.text = school.phoneNumber ?? ""
        
        var opportunities: [String] = []
        
        if let op1 = school.academicOpportunities1 {
            opportunities.append(op1)
        }
        
        if let op2 = school.academicOpportunities2 {
            opportunities.append(op2)
        }
        
        academicOpportunitiesLabel.text = opportunities.joined(separator: ", ")
        
        gradesLabel.text = school.finalgrades ?? ""
        
        websiteLabel.text = school.website ?? "" 
    }
}
