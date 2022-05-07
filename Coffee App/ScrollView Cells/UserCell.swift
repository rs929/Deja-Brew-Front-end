//
//  UserCell.swift
//  Coffee App
//
//  Created by Richie Sun on 5/3/22.
//

import Foundation
import UIKit

let fontsize = CGFloat(15)
let defaultimage = "default"

class UserCell: UICollectionViewCell{
    
    let drinkimage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: fontsize, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let favdrink: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: fontsize, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    let city: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let email: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = cellcolor
        [drinkimage, name, favdrink, email, city].forEach { thingy in
            thingy.translatesAutoresizingMaskIntoConstraints = false
            addSubview(thingy)
        }
        
        constrain()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constrain(){
        NSLayoutConstraint.activate([
            drinkimage.centerXAnchor.constraint(equalTo: centerXAnchor),
            drinkimage.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            drinkimage.heightAnchor.constraint(equalToConstant: 60),
            drinkimage.widthAnchor.constraint(equalToConstant: 60),
            
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.topAnchor.constraint(equalTo: drinkimage.bottomAnchor, constant: 10),
            
            email.centerXAnchor.constraint(equalTo: centerXAnchor),
            email.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -pad),
            
            favdrink.centerXAnchor.constraint(equalTo: centerXAnchor),
            favdrink.bottomAnchor.constraint(equalTo: email.topAnchor, constant: -10),
            
            
            city.centerXAnchor.constraint(equalTo: centerXAnchor),
            city.topAnchor.constraint(equalTo: name.bottomAnchor),
            
        ])
    }
    
    func config(str: CoffeeUser, pre: Preferences){
        drinkimage.image = UIImage(named: pre.drinkfav)
        name.text = str.username
        favdrink.text = pre.drinkfav
        email.text = str.email
        city.text = "From: \(pre.city)"
        
    }
    
}
