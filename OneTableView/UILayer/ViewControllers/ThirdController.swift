//
//  ThirdController.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 18.01.2023.
//

import Foundation
import SnapKit


class ThirdController: UIViewController {
    
//    var items: [String] = ["First", "Second", "Third","Fourth", "Fifth", "Sixth","Seventh","Eights", "Nineth", "Tenth"]
//
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
//        layout.itemSize = CGSize(width: (view.frame.size.width / 3) - 4, height: (view.frame.size.width / 3) - 4)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: 120, height: 150)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCellClass.self, forCellWithReuseIdentifier: "myCell")
        
        view.addSubview(collectionView)
        title = "Third page"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ThirdController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CustomCellClass
        
       
//        cell.labelNew.text = items[indexPath.row]
        return cell
        
    }
}

extension ThirdController: UICollectionViewDataSource {
            
}

class CustomCellClass: UICollectionViewCell {
    
    var buttonNew: UIButton = {
        var label = UIButton()
        label.backgroundColor = .systemBlue
        label.layer.cornerRadius = 10
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(buttonNew)
        backgroundColor = .systemCyan
        buttonNew.snp.makeConstraints {
            $0.edges.equalToSuperview()

        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}































