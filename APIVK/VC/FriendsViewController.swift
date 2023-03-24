//
//  FriendsViewController.swift
//  APIVK
//
//  Created by Danil Komarov on 24.03.2023.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var myTableView = UITableView()
    
    lazy var service = APIWork()
    var items = [Friends]()
    var itemArray = [Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createTableView()
        
    }
    
    func createTableView() {
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        self.myTableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identifier)
        self.myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        view.addSubview(myTableView)
        
        APIWork.shared.componentsFrendsGet{ [weak self] (item) in
            self?.items = item
            self?.itemArray = item.compactMap({
                Model(name: $0.lastName, ditail: $0.firstName, imageURL: URL(string: $0.photo50 ?? "") )
            })
            
            DispatchQueue.main.async {
                self?.myTableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier, for: indexPath) as? FriendsTableViewCell {
            cell.refresh(itemArray[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
