//
//  RegisterController.swift
//  Coffee App
//
//  Created by Richie Sun on 4/29/22.
//

import Foundation
import UIKit

var valid = true
var nextcount = 0
var sessionID: Int = 0
var city: String = ""
var age: Int = 0
var caffeinemg: Int = 0
var maxcalories: Int = 0
var hotorcold: String = ""
var drinkfav: String = ""
var favspot: String = ""
var flavors: String = ""
var bio: String = ""
var matchme: Bool = false
var prefy: Preferences = Preferences(id: 0, city: "", age: 0, caffeinemg: 0, maxcalories: 0, hotorcold: "", drinkfav: "", favspot: "", flavors: "", bio: "", matchme: false)

class RegisterController: UIViewController{
    
    var options: [String] = ["Hot", "Cold"]
    
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
    
    let steps: UITextView = {
        let label = UITextView()
        label.text = "Layer One: \n The heart of the \n Coffee Characterization"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.isEditable = false
        label.backgroundColor = .clear
        return label
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "What should fellow coffee-lovers call you?"
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let userfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter username"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "Add a layer of security:"
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let passfield1: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter password"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "Where are you from?"
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let cityfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter city"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.text = "Enter your age:"
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let agefield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter age"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let label5: UILabel = {
        let label = UILabel()
        label.text = "Provide your email:"
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let emailfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter email"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let nextbutton: UIButton = {
        let button = UIButton()
        button.setTitle("  Next  ", for: .normal)
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let dropdown: UITableView = {
        let table = UITableView()
        table.isScrollEnabled = false
        table.isHidden = true
        table.allowsMultipleSelection = false
        return table
    }()
    
    let dropbutton: UIButton = {
        let button = UIButton()
        button.setTitle( "▲", for: .normal)
        button.addTarget(self, action: #selector(press2), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.isHidden = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .systemGray4
        return button
    }()
    
    let optionreuse = "Option"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backcolor
        
        dropdown.dataSource = self
        dropdown.delegate = self
        dropdown.register(OptionCell.self, forCellReuseIdentifier: optionreuse)
        
        [logoname, steps, userfield, passfield1, cityfield, agefield, emailfield, label1, label2, label3, label4, label5, nextbutton, dropdown, dropbutton].forEach {subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        constrain()
    }
    
    func constrain(){
        NSLayoutConstraint.activate([
            
            logoname.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoname.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            steps.topAnchor.constraint(equalTo: logoname.bottomAnchor, constant: 40),
            steps.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            steps.heightAnchor.constraint(equalToConstant: 95),
            steps.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            steps.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            label1.topAnchor.constraint(equalTo: logoname.bottomAnchor, constant: 186),
            label1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            label1.heightAnchor.constraint(equalToConstant: labelh),
            userfield.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: spacing),
            userfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            userfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            userfield.heightAnchor.constraint(equalToConstant: width),
            
            
            label2.topAnchor.constraint(equalTo: userfield.bottomAnchor, constant: spacing2),
            label2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            label2.heightAnchor.constraint(equalToConstant: labelh),
            passfield1.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: spacing),
            passfield1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passfield1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            passfield1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            passfield1.heightAnchor.constraint(equalToConstant: width),
            
            
            label3.topAnchor.constraint(equalTo: passfield1.bottomAnchor, constant: spacing2),
            label3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            label3.heightAnchor.constraint(equalToConstant: labelh),
            cityfield.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: spacing),
            cityfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            cityfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            cityfield.heightAnchor.constraint(equalToConstant: width),
            
            
            label4.topAnchor.constraint(equalTo: cityfield.bottomAnchor, constant: spacing2),
            label4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            agefield.topAnchor.constraint(equalTo: label4.bottomAnchor, constant: spacing),
            agefield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            agefield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            agefield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            agefield.heightAnchor.constraint(equalToConstant: width),
            dropdown.topAnchor.constraint(equalTo: agefield.bottomAnchor),
            dropdown.leadingAnchor.constraint(equalTo: agefield.leadingAnchor),
            dropdown.trailingAnchor.constraint(equalTo: agefield.trailingAnchor),
            dropdown.heightAnchor.constraint(equalToConstant: CGFloat(options.count) * 30),
            dropbutton.topAnchor.constraint(equalTo: agefield.topAnchor),
            dropbutton.trailingAnchor.constraint(equalTo: agefield.trailingAnchor),
            dropbutton.heightAnchor.constraint(equalToConstant: width),
            
            
            label5.topAnchor.constraint(equalTo: agefield.bottomAnchor, constant: spacing2),
            label5.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            emailfield.topAnchor.constraint(equalTo: label5.bottomAnchor, constant: spacing),
            emailfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            emailfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            emailfield.heightAnchor.constraint(equalToConstant: width),
            
            nextbutton.topAnchor.constraint(equalTo: emailfield.bottomAnchor, constant: 50),
            nextbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    @objc func press(){
        if nextcount == 0{
            confirm1()
        }else if nextcount == 1{
            confirm2()
        }else{
            register()
        }
    }
    
    @objc func press2(){
        if(dropdown.isHidden){
            dropbutton.setTitle("▼", for: .normal)
            dropbutton.layer.borderColor = UIColor.systemBlue.cgColor
        }else{
            dropbutton.setTitle("▲", for: .normal)
            dropbutton.layer.borderColor = UIColor.black.cgColor
        }
        dropdown.isHidden = !dropdown.isHidden
    }
    
    func confirm1(){
        valid = true
        let fields1 = [userfield, passfield1, cityfield, agefield, emailfield]
        fields1.forEach { field in
            if field.text?.isEmpty ?? true{
                error1()
        }
        }
        guard let _: Int = Int(agefield.text ?? "") else{
            error2(type: "Age", desc: "is an integer")
            return
        }
        if valid{
            anime()
            let name = userfield.text!
            let pass = passfield1.text!
            let em = emailfield.text!
            city = cityfield.text!
            age = Int(agefield.text ?? "0") ?? 0
            
            NetworkManager.createUser(username: name, password: pass, email: em) { response in
                print(response.session_token)
                sessionID = response.id
            }
        
            
            label1.isHidden = true
            userfield.isHidden = true
            dropbutton.isHidden = false
            
            label2.text = "How strong do you like your coffee?(31-360mg)"
            passfield1.placeholder = "Enter integer (31-360mg)"
            
            label3.text = "Calories/coffee(3-500kcal)"
            cityfield.placeholder = "Enter integer (3-500kcal)"
            
            label4.text = "Hot/cold"
            agefield.placeholder = "Select..."
            agefield.isEnabled = false
            
            label5.isHidden = true
            emailfield.isHidden = true
            
            steps.text = "Layer Two: \n The body of the \n Coffee Characterization"
            fields1.forEach { field in
                field.text = ""
            }
            nextcount = nextcount + 1
                
        }
    }
    
    func confirm2(){
        valid = true
        let fields1 = [passfield1, cityfield, agefield]
        fields1.forEach { field in
            if field.text?.isEmpty ?? true{
                error1()
        }
        }
        guard let mg: Int = Int(passfield1.text ?? "") else{
            error2(type: "Caffeine mg", desc: "an integer")
            return
        }
        if (mg < 31 || mg > 360){
            error2(type: "Caffeine mg", desc: "in the range 31-360mg")
        }
        guard let cal: Int = Int(cityfield.text ?? "") else{
            error2(type: "Calories", desc: "an integer")
            return
        }
        if (cal < 3 || cal > 500){
            error2(type: "Caffeine mg", desc: "in the range 3-500kcal")
        }
        
        if valid{
            anime()
            caffeinemg = Int(passfield1.text ?? "0") ?? 0
            maxcalories = Int(cityfield.text ?? "0") ?? 0
            hotorcold = agefield.text!
            
            label1.text = "Favorite Drink:(Latte, Mocha, Cappuccino)"
            userfield.placeholder = "Enter drink"
            label1.isHidden = false
            userfield.isHidden = false
            
            label2.text = "Favorite Flavor:(Vanilla, Caramel, Chocolate)"
            passfield1.placeholder = "Enter flavor"
            
            label3.text = "Favorite Cafe spot"
            cityfield.placeholder = "Enter cafe spot"
            
            options = ["Yes", "No"]
            dropdown.reloadData()
            dropdown.addConstraint(dropdown.heightAnchor.constraint(equalToConstant: 150))
            dropdown.layoutIfNeeded()
            label4.text = "Do you want to be matched with other users"
            agefield.placeholder = "Select..."
            
            label5.text = "Do you have a bio in mind?"
            emailfield.placeholder = "Enter bio"
            label5.isHidden = false
            emailfield.isHidden = false
            
            nextbutton.setTitle("Register", for: .normal)
            
            
            steps.text = "Layer Three: \n The Crema of the \n Coffee Characterization"
            
            fields1.forEach { field in
                field.text = ""
            }
            nextcount = nextcount + 1
                
        }
    }
    
    func register(){
        valid = true
        let fields1 = [userfield, passfield1, cityfield, agefield, emailfield]
        fields1.forEach { field in
            if field.text?.isEmpty ?? true{
                error1()
        }
        }
        let a = userfield.text
        let b = passfield1.text
        if (a != "Latte" && a != "Mocha" && a != "Cappuccino"){
            error3(type: "Drink", desc: "Latte, Mocha, Cappuccino")
        }
        
        if (b != "Vanilla" && b != "Caramel" && b != "Chocolate"){
            error3(type: "Flavor", desc: "Vanilla, Caramel, Chocolate")
        }
        if valid{
            anime()
            drinkfav = userfield.text!
            flavors = passfield1.text!
            favspot = cityfield.text!
            if (agefield.text == "Yes"){
                matchme = true
            }else{
                matchme = false
            }
            bio = emailfield.text!
            
            nextcount = 0
            NetworkManager.createPrefs(id: sessionID, city: city, age: age, caffeinemg: caffeinemg, maxcalories: maxcalories, hotorcold: hotorcold, drinkfav: drinkfav, favspot: favspot, flavors: flavors, bio: bio, matchme: matchme) { response in
                print("POOOOOOOPY")
                print(sessionID)
                prefy = response
            }
            dismiss(animated: true) {
                print("registered")
            }
                
        }
    }

    
    func error1(){
        let error = UIAlertController(title: "Invalid Entry", message: "Make sure to fill in all fields!", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            print("Register Error")
        }))
        valid = false
        present(error, animated: true, completion: nil)
    }
    
    func error2(type: String, desc: String){
        let error = UIAlertController(title: "Invalid \(type)", message: "Make sure the input value is \(desc)!", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            print("Register Error")
        }))
        valid = false
        present(error, animated: true, completion: nil)
    }
    
    func error3(type: String, desc: String){
        let error = UIAlertController(title: "Invalid \(type)", message: "You must choose one of: (\(desc))!", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            print("Register Error")
        }))
        valid = false
        present(error, animated: true, completion: nil)
    }
    
    func anime(){
        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = backcolor
            self.view.backgroundColor = .black
            self.view.backgroundColor = backcolor
        }
    }
}

extension RegisterController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = dropdown.dequeueReusableCell(withIdentifier: optionreuse, for: indexPath) as? OptionCell{
            let option = options[indexPath.row]
            cell.config(str: option)
            cell.layer.borderWidth = 1
            return cell
        } else{
            return UITableViewCell()
    }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
}
extension RegisterController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = dropdown.cellForRow(at: indexPath) as? OptionCell{
            let oof = cell.label.text
            dropdown.isHidden = true
            dropbutton.setTitle("▲", for: .normal)
            dropbutton.layer.borderColor = UIColor.black.cgColor
            print(oof)
            agefield.text = oof
        } else{
            print("ERROR")
        }
    }
    
}
