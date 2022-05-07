//
//  ProfileController.swift
//  Coffee App
//
//  Created by Richie Sun on 5/1/22.
//

import Foundation
import UIKit
import Alamofire

protocol EditorDelegate {
    var users: [CoffeeUser] {get set}
    var usersview: UICollectionView {get set}
}
//Place Holder until backend
var name = "Richie"
let drink = "dummydrink"
let paddy = CGFloat(16)

class ProfileController: UIViewController {
    
    
    let userlabel: UILabel = {
        let label = UILabel()
        label.text = name
        label.font = .systemFont(ofSize: headerfont, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let greetingslabel: UILabel = {
        let label = UILabel()
        label.text = "Greetings, \(name)"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        return label
    }()
    let lines: UITextView = {
        let label = UITextView()
        label.text = "Any thoughs with your coffee today?\n________________________________\n________________________________"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.isEditable = false
        label.backgroundColor = .clear
        return label
    }()
    
    //11 between lines
    
    let biolabel: UITextView = {
        let label = UITextView()
        label.text = "-"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.isEditable = false
        label.backgroundColor = backcolor
        return label
    }()
    
    let aboutme: UILabel = {
        let label = UILabel()
        label.text = "About me"
        label.font = .systemFont(ofSize: headerfont, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let city: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let usy: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let agy: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let matchy: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let drinky: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let caffy: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let caly: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let emaily: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let coldhoty: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let flavy: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    let coffeeprefs: UILabel = {
        let label = UILabel()
        label.text = "Coffee Characteristics"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let profileimage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        imageView.contentMode = .scaleToFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = backcolor.cgColor
        imageView.layer.cornerRadius = 41
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let favdrinkslabel: UILabel = {
        let label = UILabel()
        label.text = "My Top 5 Drinks"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        label.isHidden = true
        return label
    }()
    
    let drinkfavview: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let drinksview: UICollectionView = {
        let pad: CGFloat = 10
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = pad
        flowLayout.minimumInteritemSpacing = pad
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let filters = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filters.showsHorizontalScrollIndicator = false
        filters.isHidden = true
        return filters
    }()
    
    lazy var editprofilebutton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.addTarget(self, action: #selector(editprofile), for: .touchUpInside)
        button.setTitleColor(greeny, for: .normal)
        return button
    }()
    lazy var refreshbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Refresh", for: .normal)
        button.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        button.setTitleColor(greeny, for: .normal)
        return button
    }()
    
    let drinksID = "drinkReuse"
    
    var drinks: [Drink] = []
    var favdrinks: [Drink] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backcolor
        drinksview.dataSource = self
        drinksview.delegate = self
        NetworkManager.getUser(id: sessionID) { response in
            self.userlabel.text = response.username
            self.greetingslabel.text = "Greetings, \(response.username)!"
            self.usy.text = "@\(response.username)"
            self.emaily.text = "\(response.email)"
        }
        NetworkManager.getPrefs(id: sessionID) { response in
            self.drinkfavview.image = UIImage(named: response.drinkfav)
            self.profileimage.image = UIImage(named: response.drinkfav)
            self.biolabel.text = "\(response.bio)"
            self.city.text = "\(response.city)"
            self.agy.text = "Age: \(response.age)"
            self.coldhoty.text = "• Preferred coffee: \(response.hotorcold)"
            self.caffy.text = "• Caffeine content: \(response.caffeinemg) mg"
            self.flavy.text = "• Flavor: \(response.flavors)"
            self.caly.text = "• Maximum calories: \(response.maxcalories) kcal"
            self.drinky.text = "• Favorite drink: \(response.drinkfav)"
        }
        drinksview.register(DrinksCell.self, forCellWithReuseIdentifier: drinksID)
        [userlabel, greetingslabel, favdrinkslabel, drinksview, profileimage, editprofilebutton, biolabel, lines, coffeeprefs, city, agy, matchy, drinky, caffy, caly, coldhoty, flavy, usy, emaily, drinkfavview, refreshbutton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        constrain()
    }
    
    func constrain(){
        NSLayoutConstraint.activate([
            userlabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            userlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            editprofilebutton.topAnchor.constraint(equalTo: userlabel.topAnchor),
            editprofilebutton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            
            refreshbutton.topAnchor.constraint(equalTo: userlabel.topAnchor),
            refreshbutton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            
            
            profileimage.topAnchor.constraint(equalTo: userlabel.bottomAnchor, constant: 31),
            profileimage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            profileimage.widthAnchor.constraint(equalToConstant: 82),
            profileimage.heightAnchor.constraint(equalToConstant: 82),
            
            greetingslabel.topAnchor.constraint(equalTo: profileimage.topAnchor),
            greetingslabel.leadingAnchor.constraint(equalTo: profileimage.trailingAnchor, constant: 5),
            
            lines.topAnchor.constraint(equalTo: greetingslabel.bottomAnchor, constant: -8),
            lines.leadingAnchor.constraint(equalTo: profileimage.trailingAnchor, constant: 5),
            lines.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            lines.heightAnchor.constraint(equalToConstant: 60),
            
            usy.topAnchor.constraint(equalTo: profileimage.bottomAnchor, constant: 26),
            usy.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: paddy),
            
            agy.topAnchor.constraint(equalTo: usy.bottomAnchor, constant: 6),
            agy.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: paddy),
            
            city.topAnchor.constraint(equalTo: agy.bottomAnchor, constant: 1),
            city.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: paddy),
            
            emaily.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 5),
            emaily.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: paddy),
            
            biolabel.topAnchor.constraint(equalTo: emaily.bottomAnchor, constant: 10),
            biolabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            biolabel.heightAnchor.constraint(equalToConstant: 40),
            biolabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            coffeeprefs.topAnchor.constraint(equalTo: biolabel.bottomAnchor, constant: 22),
            coffeeprefs.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: paddy),
            
            drinky.topAnchor.constraint(equalTo: coffeeprefs.bottomAnchor, constant: 26),
            drinky.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: paddy),
            
            caffy.topAnchor.constraint(equalTo: drinky.bottomAnchor),
            caffy.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: paddy),
            
            caly.topAnchor.constraint(equalTo: caffy.bottomAnchor),
            caly.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: paddy),
            
            coldhoty.topAnchor.constraint(equalTo: caly.bottomAnchor),
            coldhoty.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: paddy),
            
            flavy.topAnchor.constraint(equalTo: coldhoty.bottomAnchor),
            flavy.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: paddy),
            
            drinkfavview.topAnchor.constraint(equalTo: coldhoty.bottomAnchor, constant: 26),
            drinkfavview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            drinkfavview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            drinkfavview.heightAnchor.constraint(equalToConstant: 270),
            
            
            
            favdrinkslabel.topAnchor.constraint(equalTo: greetingslabel.bottomAnchor, constant: 80),
            favdrinkslabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            drinksview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            drinksview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            drinksview.topAnchor.constraint(equalTo: favdrinkslabel.bottomAnchor, constant: pad),
            drinksview.heightAnchor.constraint(equalToConstant: 210)
            
        ])
    }
    
    
    
    @objc func editprofile(){
        let subcontroller = EditorController()
        present(subcontroller, animated: true, completion: nil)
    }
    
    @objc func refresh(){
        NetworkManager.getPrefs(id: sessionID) { response in
            self.drinkfavview.image = UIImage(named: response.drinkfav)
            self.profileimage.image = UIImage(named: response.drinkfav)
            self.biolabel.text = "\(response.bio)"
            self.city.text = "\(response.city)"
            self.agy.text = "Age: \(response.age)"
            self.coldhoty.text = "• Preferred coffee: \(response.hotorcold)"
            self.caffy.text = "• Caffeine content: \(response.caffeinemg) mg"
            self.flavy.text = "• Flavor: \(response.flavors)"
            self.caly.text = "• Maximum calories: \(response.maxcalories) kcal"
            self.drinky.text = "• Favorite drink: \(response.drinkfav)"
        }
    }
}

extension ProfileController: UICollectionViewDelegate{
    
}
extension ProfileController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favdrinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = drinksview.dequeueReusableCell(withReuseIdentifier: drinksID, for: indexPath) as? DrinksCell{
            let drink = favdrinks[indexPath.row]
            cell.config(str: drink)
            cell.layer.borderWidth = 2
            return cell
        } else{
            return UICollectionViewCell()
    }
    }
    
    
}

extension ProfileController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
