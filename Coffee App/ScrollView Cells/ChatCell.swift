//
//  ChatCell.swift
//  Coffee App
//
//  Created by Richie Sun on 5/4/22.
//

import Foundation
import UIKit
import SDWebImage

let drinks = [""]

class ChatCell: UITableViewCell{
    
    let profimage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = backcolor
        image.contentMode = .scaleToFill
        image.layer.borderWidth = 2
        image.layer.borderColor = backcolor.cgColor
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    let imagy: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemGray
        image.contentMode = .scaleToFill
        return image
    }()
    
    let user: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    //19
    
    let place: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    //18
    
    let texty: UITextView = {
        let text = UITextView()
        text.font = .systemFont(ofSize: 12)
        text.isEditable = false
        text.textColor = .black
        text.backgroundColor = .clear
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [profimage, imagy, user, place, texty].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
        backgroundColor = backcolor
        profimage.image = UIImage(named: prefy.drinkfav)
        NSLayoutConstraint.activate([
            profimage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            profimage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            profimage.heightAnchor.constraint(equalToConstant: 51),
            profimage.widthAnchor.constraint(equalToConstant: 51),
            
            user.leadingAnchor.constraint(equalTo: profimage.trailingAnchor, constant: 5),
            user.topAnchor.constraint(equalTo: profimage.topAnchor),
            
            place.topAnchor.constraint(equalTo: user.bottomAnchor),
            place.leadingAnchor.constraint(equalTo: profimage.trailingAnchor, constant: 5),
            
            imagy.topAnchor.constraint(equalTo: profimage.bottomAnchor, constant: 8),
            imagy.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imagy.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            imagy.heightAnchor.constraint(equalToConstant: 296),
            
            //23
            
            texty.topAnchor.constraint(equalTo: imagy.bottomAnchor, constant: 5),
            texty.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: pad),
            texty.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -pad),
            texty.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(str: Post){
        NetworkManager.getPrefs(id: str.user_id) { response in
            self.profimage.image = UIImage(named: response.drinkfav) //REPLACE
        }
        let urrr = URL(string: str.image.url)
        print(str.image.url)
        imagy.sd_setImage(with: urrr, placeholderImage: UIImage(named: "loading"))
        
        //URL pass network reponse URL for image
        //Placeholder image
        //Completion
        user.text = str.username
        place.text = "@Starbucks"
        texty.text = str.content
    }

}
