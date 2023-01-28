
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
    
    //Schools ViewModel
    private let schoolsViewModel: SchoolsViewModel = SchoolsViewModel()
    
    //Array for holding data about schools
    var items: [School] = []
    
    
    //Custom Button
    var bottomCustomButton: CustomButton = CustomButton()
    
    //Cancellable for Combine
    private var cancellables = Set<AnyCancellable>()
    
    

      
    
    private var button: UIButton = {
        let uiButton = UIButton()
        uiButton.backgroundColor = .systemBackground
        uiButton.setTitle("Submit", for: .normal)
        uiButton.configuration = .filled()
        uiButton.configuration?.cornerStyle = .capsule
        return uiButton
    }()
    
    private var uiTextView: UITextView = {
        let uitextView = UITextView()
        uitextView.backgroundColor = .orange
        uitextView.layer.borderColor = UIColor.black.cgColor
        uitextView.layer.borderWidth = 1.0
        return uitextView
    }()
    
    private var UITextVieww: UITextView = {
        let UITextVieww = UITextView()
        UITextVieww.backgroundColor = .blue
        return UITextVieww
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        return tableView
        
    }()
    
   
    
    
    private func setupBinders() {
        schoolsViewModel.$schools.receive(on: RunLoop.main)
            .sink { schools in
                    print("retrieved \(schools.count)")
                self.items = schools
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
        title = "Welcome project"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        view.addSubview(button)
        bottomCustomButton.setupButton()
        addActionToCustomButton()
        bottomCustomButton.setTitle("Hello", for: .normal)
        view.addSubview(bottomCustomButton)
        
      //  view.addSubview(uiTextView)
        
        
        tableView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(button.snp.top)
        }
    
        button.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
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
        
        addCellItem()
        
        schoolsViewModel.getSchools()
        
        setupBinders()
        
    }
    
    func addActionBlueButton() {
        button.addTarget(self, action: #selector(moveNextPage), for: .touchUpInside)
    }
    
    func addCellItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add cell", style: .plain, target: self, action: #selector(addCell))
        
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
    
    @objc func addCell() {
      //  items.append("\(items.count + 1)")
        tableView.reloadData()
    }
    
//    @objc func buttonPressed() {
//        if uiTextView.text.isEmpty {
//
//            uiTextView.layer.borderColor = UIColor.red.cgColor
//            uiTextView.layer.borderWidth = 10.0
//
//        var alertController = UIAlertController(title: "Warning", message: "You tapped it", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
//            (action) in
//
//        }
//        alertController.addAction(cancelAction)
//
//
//        let OKAction = UIAlertAction(title: "OK", style: .destructive) { [self] (action) in
//            self.uiTextView.layer.borderWidth = 1.0
//        }
//
//        alertController.addAction(OKAction)
//
//        present(alertController, animated: true)
//        }
//    }
//
    
}
//
//extension ViewController: UITextViewDelegate {
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        print("editing started in address text view")
//        uiTextView.layer.borderColor = UIColor.green.cgColor
//        uiTextView.layer.borderWidth = 10.0
//    }
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        print("should change text in \(text)")
//
//        return true
//    }
//
//}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = SecondViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        present(navVC, animated: true)
        print("did select item \(items[indexPath.row].dbn)")
    }
    
    
    
        
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _,_,handler in
            self.items.remove(at: indexPath.row)
            tableView.reloadData()
            handler(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCell
        cell.label.text = "The row number is: " + items[indexPath.row].dbn
        return cell
    }
    
    
}


class MyCell: UITableViewCell {
    
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
            $0.size.equalTo(100)
            $0.edges.equalTo(UIEdgeInsets(top: 0, left: 30, bottom:0 , right: 0))
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        title = "Fuck You"
    }
}
