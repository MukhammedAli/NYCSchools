//
//  SecondViewController.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 17.01.2023.
//

import UIKit
import SnapKit

class SecondVController: UIViewController {
//    var fSet: Set<Int> = [1,2]
//    var sSet: Set<Int> = [1,2,3]
    
let items: [String] = ["Algeria", "Kazakhstan", "Moroco", "USA",
"Iraq", "Iran", "Ukraine", "Afganistan", "Turkey","Azerbaijan"]
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        sSet.subtract(fSet)
        title = "Second Page"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SecondVController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MCell
        cell.label.text = " " + items[indexPath.row]
        return cell
    }
}

extension SecondVController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let newController = ThirdController()
//        newController.modalPresentationStyle = .fullScreen
//        present(newController, animated: true)
//        navigationController?.pushViewController(newController, //animated: true)
    }
    
   
}

class MCell: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.edges.equalTo(UIEdgeInsets(top:0, left: 10,
                                          bottom: 0, right: 0 ))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

















