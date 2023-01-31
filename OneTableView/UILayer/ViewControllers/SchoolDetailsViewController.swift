////
////  SchoolDetailsViewController.swift
////  OneTableView
////
////  Created by  Mukhammed Ali Khamzayev on 30.01.2023.
////
//
//import Foundation
//import UIKit
//import SnapKit
//
//
//class SchoolDetailsViewController: UIViewController {
//    
//    
//    private var sectionList: [String] = []
//    private var collectionView: UICollectionView?
//    
//    private var viewModel: SchoolDetailsViewModel?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = viewModel?.school.schoolName ?? ""
//        view.backgroundColor = .white
//        setupCollectionView()
//    }
//    
//    private struct Constants {
//        static let schoolDetailsCellIdentifier: String = "schoolDetailsCell"
//        static let detailsCellHeight: CGFloat = 360
//        static let sectoinHeaderCellIdentifier: String = "sectionHeader"
//        static let sectionHeight: CGFloat = 50
//    }
//    
//    func setupCollectionView() {
//         let collectionViewLayout = UICollectionViewFlowLayout()
//         collectionViewLayout.itemSize = CGSize(width: view.frame.size.width, height: Constants.detailsCellHeight)
//        collectionViewLayout.headerReferenceSize = CGSize(width: view.frame.size.width, height: Constants.sectionHeight)
//        collectionViewLayout.scrollDirection = .vertical
//        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
//        
//        guard let collectionView = collectionView else {
//            return
//        }
//        
//        view.addSubview(collectionView)
//        collectionView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        collectionView.backgroundColor = .white
//        collectionView.alwaysBounceVertical = true
//        
//        collectionView.register(SchoolDetailsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.schoolDetailsCellIdentifier)
//        collectionView.register(SchoolSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.sectionHeaderCellIdentifier)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//}
//
//extension SchoolDetailsViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch indexPath.section {
//            case 0:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.schoolDetailsCellIdentifier, for: indexPath)
//            guard let collectionViewCell = cell as? SchoolDetailsCollectionViewCell,
//                  let school = viewModel?.school else {
//                
//            }
//            default:
//                return UICollectionViewCell()
//        }
//        
//    }
//}
//
//extension SchoolDetailsViewController: UICollectionViewDelegate {
//        
//}
