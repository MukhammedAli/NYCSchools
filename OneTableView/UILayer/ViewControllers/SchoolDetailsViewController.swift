//
//  SchoolDetailsViewController.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 30.01.2023.
//

import Foundation
import UIKit
import SnapKit


class SchoolDetailsViewController: UIViewController {
    
    
   
    private var collectionView: UICollectionView?
    
    var viewModel: SchoolDetailsViewModel?
    
    private var sectionList: [String] = ["School details"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel?.school.schoolName ?? ""
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    private struct Constants {
        static let schoolDetailsCellIdentifier: String = "schoolDetailsCell"
        static let detailsCellHeight: CGFloat = 360
        static let sectionHeaderCellIdentifier: String = "sectionHeader"
        static let sectionHeight: CGFloat = 50
    }
    
    func setupCollectionView() {
         let collectionViewLayout = UICollectionViewFlowLayout()
         collectionViewLayout.itemSize = CGSize(width: view.frame.size.width, height: Constants.detailsCellHeight)
        collectionViewLayout.headerReferenceSize = CGSize(width: view.frame.size.width, height: Constants.sectionHeight)
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(SchoolDetailsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.schoolDetailsCellIdentifier)
        collectionView.register(SchoolSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.sectionHeaderCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SchoolDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.schoolDetailsCellIdentifier, for: indexPath)
            guard let schoolDetailsCell = cell as? SchoolDetailsCollectionViewCell,
                  let school = viewModel?.school else {
                return cell
            }
            schoolDetailsCell.populate(school: school)
            return schoolDetailsCell
            default:
                return UICollectionViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader,
           let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.sectionHeaderCellIdentifier, for: indexPath) as? SchoolSectionHeaderView {
            sectionHeader.headerLabel.text = sectionList[indexPath.section]
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

extension SchoolDetailsViewController: UICollectionViewDelegate {
        
}
