//
//  SchoolListStateView.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 01.02.2023.
//

import Foundation
import UIKit
import SnapKit

enum SchoolLoadState {
    case loaded
    case empty
    case error
}

class SchoolListStateView: UIView {
    private struct Constants {
        static let stackViewSpacing: CGFloat = 30
        static let stackViewInsets = UIEdgeInsets(top: 200, left: 100, bottom: 200, right: 100)
        static let headerLabelWidth: CGFloat = 200
        static let iconImageSize = CGSize(width: 200, height: 200)
        
        static let headerLabelFontSize: CGFloat = 25
        static let messageLabelFontSize: CGFloat = 18
    }
    
    var headerLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.headerLabelFontSize)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var messageLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.messageLabelFontSize)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.stackViewInsets)
        }
        
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(messageLabel)
        
        headerLabel.snp.makeConstraints {
            $0.width.equalTo(Constants.headerLabelWidth)
        }
        
        messageLabel.snp.makeConstraints {
            $0.width.equalTo(Constants.headerLabelWidth)
        }
        
        stackView.addArrangedSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.iconImageSize)
        }
        
        
    }
    
     func update(for state: SchoolLoadState) {
        switch state {
            case .error:
                headerLabel.text = "School loading error"
                messageLabel.text = "Description of loading error"
                iconImageView.image = UIImage(named: "error")
            case .empty:
                headerLabel.text = "No data found"
                messageLabel.text = "School list is empty"
                iconImageView.image = UIImage(named: "customer")
            case .loaded:
                break
        }
    }
    
    
    
    
}
