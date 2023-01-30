//
//  SchoolsSectionHeaderView.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 30.01.2023.
//

import Foundation
import UIKit
import SnapKit

class SchoolSectionHeaderView: UICollectionReusableView {
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 5)
    }
    
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
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
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.edgeInsets)
        }
    }
    
}
