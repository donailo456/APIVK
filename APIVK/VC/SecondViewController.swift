//
//  SecondViewController.swift
//  APIVK
//
//  Created by Danil Komarov on 24.03.2023.
//

import UIKit

class SecondViewController: UIViewController {
    var friendsButton: UIButton = {
       var button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        button.setTitle("Friends", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 15
        return button
    }()
    var photosButton: UIButton = {
       var button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        button.setTitle("Photos", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createButton()
        
    }
    func createButton() {
        friendsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(friendsButton)
        friendsButton.addTarget(self, action: #selector(actionGetFriends), for: .touchUpInside)
        
        view.addSubview(photosButton)
        photosButton.translatesAutoresizingMaskIntoConstraints = false
        photosButton.addTarget(self, action: #selector(actionGetPhoto), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            friendsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 2),
            friendsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130),
            friendsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -130 ),
            photosButton.topAnchor.constraint(equalTo: friendsButton.bottomAnchor, constant: 10),
            photosButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130),
            photosButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -130),
        ])
    }
    
    @objc func actionGetFriends() {
        let vc = FriendsViewController()
        present(vc, animated: true)
    }
    @objc func actionGetPhoto() {
        let vc = PhotosViewController()
        present(vc, animated: true)
    }

}

