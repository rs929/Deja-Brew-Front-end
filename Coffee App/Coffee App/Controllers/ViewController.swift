//
//  ViewController.swift
//  Coffee App
//
//  Created by Richie Sun on 4/29/22.
//

import UIKit

//DEFAULT DATA REMOVE LATER
let factoid = "-The world's most expensive coffee is $600.00/pound-"
let drinkname = "Pink Drink"
let drinkimage = "pinkdrink"

class ViewController: UIViewController{
    
    
    let place: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.text = "Nothing to See Here yet... (W.I.P)"
        label.textColor = .red
        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        return label
    }()
    
    let topbar: UILabel = {
        let label = UILabel()
        label.backgroundColor = factcolor
        return label
    }()
    
    let facts: UILabel = {
        let label = UILabel()
        label.text = factoids.randomElement() //REPLACE
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = factcolor
        return label
    }()
    
    let starbsprof: UIImageView = {
        let image = UIImageView(image: UIImage(named: "starbs")) //REPLACE
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let drinkoftheday: UILabel = {
        let label = UILabel()
        label.text = "Drink of the Day"
        label.font = .systemFont(ofSize: headerfont, weight: .bold)
        return label
    }()
    
    let nomatch: UILabel = {
        let label = UILabel()
        label.text = "No Current Matches :("
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = greeny
        label.isHidden = true
        return label
    }()
    
    let drinklabel: UILabel = {
        let label = UILabel()
        label.text = drinkname //REPLACE
        label.font = .systemFont(ofSize: userfont, weight: .semibold)
        return label
    }()
    
    let starbs: UILabel = {
        let label = UILabel()
        label.text = "@Starbucks"
        label.font = .systemFont(ofSize: spotfont, weight: .semibold)
        return label
    }()
    
    let drinkview: UIImageView = {
        let image = UIImageView(image: UIImage(named: drinkimage)) //REPLACE
        image.contentMode = .scaleToFill
        image.backgroundColor = backcolor
        return image
    }()
    
    let usermatch: UILabel = {
        let label = UILabel()
        label.text = "User Match of the Day"
        label.font = .systemFont(ofSize: headerfont, weight: .bold)
        return label
    }()
    
    var users: [CoffeeUser] = []
    
    var usersview: UICollectionView = {
        let pad: CGFloat = 10
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 25 //maybe change
        flowLayout.minimumInteritemSpacing = 25
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
        let filters = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filters.showsHorizontalScrollIndicator = false
        filters.backgroundColor = backcolor
        return filters
    }()
    
    let usersID = "userReuse"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backcolor
        // Do any additional setup after loading the view.
        
        NetworkManager.getDrink(id: sessionID) { response in
            self.drinklabel.text = response.name
            self.drinkview.image = UIImage(named: response.name)
            print(response.name)
        }
        
        NetworkManager.getAllUsers(id: sessionID) { response in
            self.users = response
            print(self.users)
            self.usersview.reloadData()
            if (self.users.count == 0){
                self.nomatch.isHidden = false
            }
        }
        
        
        
        usersview.dataSource = self
        usersview.delegate = self
        usersview.register(UserCell.self, forCellWithReuseIdentifier: usersID)
        [drinkoftheday, starbs, starbsprof, usermatch, drinklabel, drinkview, topbar, facts, usersview, nomatch].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        constrain()
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(reffy), for: .valueChanged)
        usersview.refreshControl = refresh
        //createdummyusers()
    }
    @objc func reffy(){
        NetworkManager.getAllUsers(id: sessionID) { response in
            self.users = response
            print(self.users)
            self.usersview.reloadData()
            if (self.users.count == 0){
                self.nomatch.isHidden = false
            }
            self.usersview.refreshControl?.endRefreshing()
    }
        facts.text = factoids.randomElement()
    }
    
    func constrain(){
        NSLayoutConstraint.activate([
            topbar.topAnchor.constraint(equalTo: view.topAnchor),
            topbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topbar.heightAnchor.constraint(equalToConstant: 40),
            
            facts.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            facts.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            facts.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            facts.heightAnchor.constraint(equalToConstant: 100),
            
            drinkoftheday.topAnchor.constraint(equalTo: facts.bottomAnchor, constant: pad),
            drinkoftheday.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            starbsprof.topAnchor.constraint(equalTo: drinkoftheday.bottomAnchor, constant: pad),
            starbsprof.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            starbsprof.heightAnchor.constraint(equalToConstant: 47),
            starbsprof.widthAnchor.constraint(equalToConstant: 47),
            drinklabel.topAnchor.constraint(equalTo: starbsprof.topAnchor),
            drinklabel.leadingAnchor.constraint(equalTo: starbsprof.trailingAnchor, constant: 5),
            starbs.bottomAnchor.constraint(equalTo: starbsprof.bottomAnchor),
            starbs.leadingAnchor.constraint(equalTo: starbsprof.trailingAnchor, constant: 5),
            
            drinkview.topAnchor.constraint(equalTo: starbs.bottomAnchor, constant: 18),
            drinkview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 24),
            drinkview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            drinkview.heightAnchor.constraint(equalToConstant: 270),
            
            //25
            
            usermatch.topAnchor.constraint(equalTo: drinkview.bottomAnchor, constant: 5),
            usermatch.leadingAnchor.constraint(equalTo: drinkview.leadingAnchor),
            
            usersview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usersview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 11),
            usersview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -11),
            usersview.topAnchor.constraint(equalTo: usermatch.bottomAnchor, constant: 5),
            usersview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            nomatch.centerXAnchor.constraint(equalTo: usersview.centerXAnchor),
            nomatch.centerYAnchor.constraint(equalTo: usersview.centerYAnchor)
        ])
    }
    //NAVBAR 21
    
    
    @objc func pushProfileController() {
        navigationController?.pushViewController(ProfileController(), animated: true)
    }
    
    func createdummyusers(){
        ["Richie", "Gabby", "Aditya", "Vannessa", "Noelle", "Justin", "Theodora", "Eileen"].forEach { user in
            users.append(CoffeeUser(id: 1, username: user, email: "\(user)@cornell.edu"))
        }
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = usersview.dequeueReusableCell(withReuseIdentifier: usersID, for: indexPath) as? UserCell{
            let user = users[indexPath.row]
            NetworkManager.getPrefs(id: user.id) { response in
                cell.config(str: user, pre: response)
                print("cell created")
            }
            return cell
        } else{
            return UICollectionViewCell()
    }
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 190)
    }
}


