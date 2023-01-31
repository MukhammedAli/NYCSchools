
//
//  ViewController.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 03.11.2022.
//

import UIKit
import SnapKit
import Combine

class ViewController: UIViewController {
    
    private struct Constants {
        static let cellIdentifier: String = "schoolCell"
        static let cellHeight: CGFloat = 100
        static let sectionHeaderIdentifier: String = "sectionHeader"
        static let sectionHeight: CGFloat = 50
    }
    
    //Schools ViewModel
    private let schoolsViewModel: SchoolsViewModel = SchoolsViewModel()
    
    //Array for holding data about schools
    var items: [School] = []
    
    
    //Custom Button
    var bottomCustomButton: CustomButton = CustomButton()
    
    //Cancellable for Combine
    private var cancellables = Set<AnyCancellable>()
    
    private var collectionView: UICollectionView?
    

    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.size.width, height: Constants.cellHeight)
        
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
        collectionView.register(SchoolCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.register(SchoolSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.sectionHeaderIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
   
    
    private var button: UIButton = {
        let uiButton = UIButton()
        uiButton.backgroundColor = .systemBackground
        uiButton.setTitle("Submit", for: .normal)
        uiButton.configuration = .filled()
        uiButton.configuration?.cornerStyle = .capsule
        return uiButton
    }()
    
    
    private func setupBinders() {
        schoolsViewModel.$schools.receive(on: RunLoop.main)
            .sink { schools in
               
                    print("retrieved \(schools.count)")
               // self.items = schools
                    self.collectionView?.reloadData()
                
                    
            }
//            .sink {  schools in
//            if let schools = schools {
//                    print("retrieved \(schools.count)")
//                    //self?.items.append(contentsOf: schools)
//                }
//            }
            .store(in: &cancellables)
        schoolsViewModel.$error.receive(on: RunLoop.main).sink {[weak self] error in
            if let error = error {
                let alert = UIAlertController(title: "Error",
                                              message: "Could not retrieve schools \(error.localizedDescription)",
                                              preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alert.addAction(action)
               self?.present(alert, animated: true)
            }
        }.store(in: &cancellables)
                   
        
                   
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //by using closures
        
//       { [weak self] (schools, error) in
//            if let error = error {
//                let alert = UIAlertController(title: "Error",
//                                              message: "Could not retrieve schools \(error.localizedDescription)",
//                                              preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .default)
//                alert.addAction(action)
//               self?.present(alert, animated: true)
//            }
//
//            if let schools = schools {
//                print("retrieved \(schools.count)")
//            }
//      }
        

//        let api:SchoolAPILogic = SchoolAPI()
//        api.getSchools { result in
//            switch result {
//            case .failure(let error):
//                print("error retrieving schools \(error.localizedDescription)")
//                break
//            case .success(let schools):
//                if let schools = schools {
//                    self.items = schools
//                    print("found schools \(schools.count)")
//                }
//                break
//            }
//        }
        view.backgroundColor = .systemBackground
        title = "NYC Schools"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(button)
        bottomCustomButton.setupButton()
        addActionToCustomButton()
        bottomCustomButton.setTitle("Hello", for: .normal)
        view.addSubview(bottomCustomButton)
        

        button.snp.makeConstraints {
            
            if let collectionView = collectionView {
                $0.top.equalTo(collectionView.snp.bottom)
            }
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(10)
//            $0.bottom.equalToSuperview().inset(100)
            $0.bottom.equalTo(bottomCustomButton.snp.top).offset(-20)
            $0.width.equalTo(5)
            $0.height.equalTo(80)
        }
        
        bottomCustomButton.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.width.equalTo(1)
            $0.height.equalTo(80)
        }
        
        addActionBlueButton()
        
        schoolsViewModel.getSchools()
        
        setupCollectionView()
        
        setupBinders()
        
    }
    
    func addActionBlueButton() {
        button.addTarget(self, action: #selector(moveNextPage), for: .touchUpInside)
    }
    
   
    
    func addActionToCustomButton() {
        bottomCustomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
    }
    
   
    @objc func moveNextPage() {
        let nextScreen = SecondVController()
        nextScreen.title = "Second screen"
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    @objc func bottomButtonTapped() {
        bottomCustomButton.shake()
    }
    
    

    
}







extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader ,
           let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:  Constants.sectionHeaderIdentifier, for: indexPath) as? SchoolSectionHeaderView {
            sectionHeader.headerLabel.text =
            schoolsViewModel.schoolSectionsList?[indexPath.section].city
            return sectionHeader
            
        }
        
        return UICollectionReusableView()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? SchoolCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let schoolSection = schoolsViewModel.schoolSectionsList?[indexPath.section] {
        let schools = schoolSection.schools[indexPath.item]
        cell.populate(schools)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schoolsViewModel.schoolSectionsList?[section].schools.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return schoolsViewModel.schoolSectionsList?.count ?? 1
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let schools = schoolsViewModel.schoolSectionsList?[indexPath.section].schools[indexPath.item] {
            
        }
    }
}


