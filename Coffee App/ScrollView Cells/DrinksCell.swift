//
//  DrinksCell.swift
//  Coffee App
//
//  Created by Richie Sun on 5/1/22.
//

import Foundation
import UIKit

class DrinksCell: UICollectionViewCell {
    
    let filty: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    func config(str: Drink){
        let imagename = str.name
        filty.image = UIImage(named: imagename)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.black.cgColor
        
        filty.translatesAutoresizingMaskIntoConstraints = false
        addSubview(filty)
        
        constrain()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constrain(){
        NSLayoutConstraint.activate([
            filty.topAnchor.constraint(equalTo: topAnchor),
            filty.centerXAnchor.constraint(equalTo: centerXAnchor),
            filty.centerYAnchor.constraint(equalTo: centerYAnchor),
            filty.heightAnchor.constraint(equalToConstant: 200),
            filty.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
