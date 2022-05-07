//
//  LoginController.swift
//  Coffee App
//
//  Created by Richie Sun on 4/29/22.
//

import Foundation

import UIKit

var allow = false
//Font size of text fields
let textfieldfont = CGFloat(20)
//Padding of text fields lead and trail
let pad = CGFloat(19)
//Width of text fields
let width = CGFloat(46)
//Height of labels
let labelh = CGFloat(24)
//Spacing between label and text field
let spacing = CGFloat(9)
//Spacing between entries
let spacing2 = CGFloat(21)

//Font size of the username
let userfont = CGFloat(20)
//Font size of coffee place
let spotfont = CGFloat(20)
//Font size of headers
let headerfont = CGFloat(32)
//background color
let backcolor = UIColor(red: 240/255, green: 214/255, blue: 175/255, alpha: 1)
let factcolor = UIColor(red: 134/255, green: 92/255, blue: 92/255, alpha: 1)
let cellcolor = UIColor(red: 234/255, green: 121/255, blue: 121/255, alpha: 1)
let greeny = UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 1)

var useuse = ""


class LoginController: UIViewController{
    
    
    let background: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background2")!)
        image.contentMode = .scaleAspectFill
        image.layer.opacity = 0.35
        return image
    }()
    
    let logoname: UILabel = {
        let label = UILabel()
        label.text = "Déjà-Brew!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let userfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter email/username"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        text.autocapitalizationType = .none

        return text
    }()
    
    let passfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter password"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        text.autocapitalizationType = .none
        return text
    }()
    
    let login: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        return button
    }()
    
    let createacc: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.addTarget(self, action: #selector(presentRegisterController), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    
    let forgotpass: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backcolor
        // Do any additional setup after loading the view.
        [logoname, userfield, passfield, login, createacc, forgotpass].forEach {subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        constrain()
    }
    
    func constrain() {
        NSLayoutConstraint.activate([
            
            logoname.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            logoname.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userfield.topAnchor.constraint(equalTo: logoname.bottomAnchor, constant: 130),
            userfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            userfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            userfield.heightAnchor.constraint(equalToConstant: width),
            
            passfield.topAnchor.constraint(equalTo: userfield.bottomAnchor, constant: 10),
            passfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            passfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            passfield.heightAnchor.constraint(equalToConstant: width),
            
            
            login.topAnchor.constraint(equalTo: passfield.bottomAnchor, constant: 70),
            login.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            createacc.topAnchor.constraint(equalTo: passfield.bottomAnchor, constant: 40),
            createacc.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            forgotpass.topAnchor.constraint(equalTo: createacc.topAnchor),
            forgotpass.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func presentRegisterController() {
        let subcontroller = RegisterController()
        present(subcontroller, animated: true, completion: nil)
        nextcount = 0
}
    @objc func pushViewController() {
        let user = userfield.text!
        let pass = passfield.text!
        NetworkManager.login(username: user, password: pass) { response in
            sessionID = response.id
            allow = true
            let tabbar = UITabBarController()
            let vc1 = ViewController()
            let vc2 = FeedController()
            let vc3 = ProfileController()
            vc1.title = "Home"
            vc2.title = "Feed"
            vc3.title = "Profile"
            tabbar.setViewControllers([vc1, vc2, vc3], animated: false)
            tabbar.modalPresentationStyle = .fullScreen
            
            guard let coolio = tabbar.tabBar.items else{
                return
            }
            
            let icons = ["house.fill", "square.and.pencil",  "person.fill"]
            
            for item in 0...coolio.count-1{
                coolio[item].image = UIImage(systemName: icons[item])
            }
            tabbar.tabBar.backgroundColor = greeny
            tabbar.tabBar.unselectedItemTintColor = .black
            tabbar.tabBar.alpha = 0.9
            tabbar.tabBar.layer.borderWidth = 1
            self.present(tabbar, animated: true) {
                print("Tabby")
            }
        }
        NetworkManager.getUser(id: sessionID) { response in
            useuse = response.username
        }
        
        
    }

}

