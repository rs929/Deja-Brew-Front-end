//
//  EditorController.swift
//  Coffee App
//
//  Created by Richie Sun on 5/3/22.
//

import Foundation
import UIKit

var succ = false
let wid = CGFloat(32)
class EditorController: UIViewController{
    var favdrinks: [Drink] = []
    
    let logoname: UILabel = {
        let label = UILabel()
        label.text = "Déjà-Brew!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let rewrite: UITextView = {
        let text = UITextView()
        text.text = "Rewriting your\nCoffee Conte..."
        text.textColor = .black
        text.font = .systemFont(ofSize: 24, weight: .semibold)
        text.backgroundColor = backcolor
        text.isEditable = false
        text.textAlignment = .center
        return text
    }()
    
    let birthlabel: UILabel = {
        let label = UILabel()
        label.text = "Happy Birthday? Are ya..."
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let birthfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter new age"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let citylabel: UILabel = {
        let label = UILabel()
        label.text = "Where's your new home?"
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
    
    let biolabel: UILabel = {
        let label = UILabel()
        label.text = "Rewrite your story..."
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let biofield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter new bio"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let drinklabel: UILabel = {
        let label = UILabel()
        label.text = "Currently Hating your old favorite?"
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let drinkfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter new favorite drink"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let callabel: UILabel = {
        let label = UILabel()
        label.text = "More calories?"
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let calfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter new integer (3-500kcal)"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let cafflabel: UILabel = {
        let label = UILabel()
        label.text = "More caffeine?"
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let cafffield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter new integer (31-360mg)"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let templabel: UILabel = {
        let label = UILabel()
        label.text = "Hot or Cold?"
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let tempfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter new temp preference"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    let flavorlabel: UILabel = {
        let label = UILabel()
        label.text = "Switch up the flavor?"
        label.font = .systemFont(ofSize: textfieldfont)
        label.textColor = .black
        return label
    }()
    
    let flavorfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter new flavor"
        text.textColor = .black
        text.font = .systemFont(ofSize: textfieldfont)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 2
        return text
    }()
    
    lazy var savebutton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(updateprof), for: .touchUpInside)
        button.setTitleColor(.systemGreen, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backcolor
        [logoname, rewrite, birthlabel, birthfield, citylabel, cityfield, biolabel, biofield, drinklabel, drinkfield, cafflabel, cafffield, callabel, calfield, templabel, tempfield, flavorlabel, flavorfield, savebutton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        constrain()
    }
    
    func constrain(){
        NSLayoutConstraint.activate([
            logoname.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoname.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rewrite.topAnchor.constraint(equalTo: logoname.bottomAnchor, constant: 33),
            rewrite.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rewrite.heightAnchor.constraint(equalToConstant: 60),
            rewrite.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rewrite.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            birthlabel.topAnchor.constraint(equalTo: rewrite.bottomAnchor, constant: 33),
            birthlabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            birthfield.topAnchor.constraint(equalTo: birthlabel.bottomAnchor),
            birthfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            birthfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            birthfield.heightAnchor.constraint(equalToConstant: wid),
            
            citylabel.topAnchor.constraint(equalTo: birthfield.bottomAnchor, constant: 16),
            citylabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            cityfield.topAnchor.constraint(equalTo: citylabel.bottomAnchor),
            cityfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            cityfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            cityfield.heightAnchor.constraint(equalToConstant: wid),
            
            biolabel.topAnchor.constraint(equalTo: cityfield.bottomAnchor, constant: 16),
            biolabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            biofield.topAnchor.constraint(equalTo: biolabel.bottomAnchor),
            biofield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            biofield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            biofield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            biofield.heightAnchor.constraint(equalToConstant: wid),
            
            drinklabel.topAnchor.constraint(equalTo: biofield.bottomAnchor, constant: 16),
            drinklabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            drinkfield.topAnchor.constraint(equalTo: drinklabel.bottomAnchor),
            drinkfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            drinkfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            drinkfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            drinkfield.heightAnchor.constraint(equalToConstant: wid),
            
            cafflabel.topAnchor.constraint(equalTo: drinkfield.bottomAnchor, constant: 16),
            cafflabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            cafffield.topAnchor.constraint(equalTo: cafflabel.bottomAnchor),
            cafffield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cafffield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            cafffield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            cafffield.heightAnchor.constraint(equalToConstant: wid),
            
            callabel.topAnchor.constraint(equalTo: cafffield.bottomAnchor, constant: 16),
            callabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            calfield.topAnchor.constraint(equalTo: callabel.bottomAnchor),
            calfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            calfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            calfield.heightAnchor.constraint(equalToConstant: wid),
            
            templabel.topAnchor.constraint(equalTo: calfield.bottomAnchor, constant: 16),
            templabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            tempfield.topAnchor.constraint(equalTo: templabel.bottomAnchor),
            tempfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            tempfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            tempfield.heightAnchor.constraint(equalToConstant: wid),
            
            flavorlabel.topAnchor.constraint(equalTo: tempfield.bottomAnchor, constant: 16),
            flavorlabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            flavorfield.topAnchor.constraint(equalTo: flavorlabel.bottomAnchor),
            flavorfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flavorfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            flavorfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            flavorfield.heightAnchor.constraint(equalToConstant: wid),
            
            savebutton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            savebutton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
        ])
    }
    
    @objc func updateprof(){
        succ = true
        let fields1 = [birthfield, cityfield, biofield, drinkfield, cafffield, calfield, tempfield, flavorfield]
        fields1.forEach { field in
            if field.text?.isEmpty ?? true{
                error1()
            }
        }
        guard let ag: Int = Int(birthfield.text ?? "0") else{
            error2(type: "Age", desc: "an integer")
            return
        }
        let a = drinkfield.text ?? ""
        if (a != "Latte" && a != "Mocha" && a != "Cappuccino"){
            error3(type: "Drink", desc: "Latte, Mocha, Cappuccino")
        }
        guard let mg: Int = Int(cafffield.text ?? "0") else{
            error2(type: "Caffeine mg", desc: "an integer")
            return
        }
        if (mg < 31 || mg > 360){
            error2(type: "Caffeine mg", desc: "in the range 31-360mg")
        }
        guard let cal: Int = Int(calfield.text ?? "0") else{
            error2(type: "Calories", desc: "an integer")
            return
        }
        if (cal < 3 || cal > 500){
            error2(type: "Caffeine mg", desc: "in the range 3-500kcal")
        }
        let b = flavorfield.text ?? ""
        let c = tempfield.text ?? ""
        if (c != "Hot" && c != "Cold"){
            error3(type: "Temperature", desc: "Hot, Cold")
        }
        if (b != "Vanilla" && b != "Caramel" && b != "Chocolate"){
            error3(type: "Flavor", desc: "Vanilla, Caramel, Chocolate")
        }
        if (succ){
            NetworkManager.updatePrefs(id: sessionID, matchme: prefy.matchme, age: ag, city: cityfield.text!, caffeinemg: mg, maxcalories: cal, hotorcold: c, drinkfav: a, favspot: prefy.favspot, flavors: b, bio: biofield.text!) { response in
                print("PROFILE EDIT SUCCESS")
            }
        }
        dismiss(animated: true) {
            print("registered")
        }
    }
    
    func error1(){
        let error = UIAlertController(title: "Invalid Entry", message: "Make sure to fill in all fields!", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            print("Update Error")
        }))
        succ = false
        present(error, animated: true, completion: nil)
    }
    
    func error2(type: String, desc: String){
        let error = UIAlertController(title: "Invalid \(type)", message: "Make sure the input value is \(desc)!", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            print("Update Error")
        }))
        succ = false
        present(error, animated: true, completion: nil)
    }
    
    func error3(type: String, desc: String){
        let error = UIAlertController(title: "Invalid \(type)", message: "You must choose one of: (\(desc))!", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            print("Update Error")
        }))
        succ = false
        present(error, animated: true, completion: nil)
    }
    
        //title to rewrite 33
        //rewrite to birthlabel 33
        //17
        //textfield height 16
        //textfield to lable 16
        //19 sides

}
