//
//  ChatController.swift
//  Coffee App
//
//  Created by Richie Sun on 5/5/22.
//

import Foundation
import UIKit

class ChatController: UIViewController{
    
    let postbutton: UIButton = {
        let button = UIButton()
        button.setTitle("post", for: .normal)
        button.addTarget(self, action: #selector(post), for: .touchUpInside)
        button.setTitleColor(.systemGreen, for: .normal)
        return button
    }()
    
    let contentfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter Message"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backcolor
        [contentfield, postbutton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            contentfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            contentfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            postbutton.topAnchor.constraint(equalTo: contentfield.topAnchor, constant: 50),
            postbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func post(){
        let imagy = NetworkManager.convertImage(img: UIImage(named: "pinkdrink")!)
        print(imagy)
        NetworkManager.createPost(id: sessionID, content: contentfield.text!, image: imagy) { response in
            print("postyyyyy")
        }
    }
}

