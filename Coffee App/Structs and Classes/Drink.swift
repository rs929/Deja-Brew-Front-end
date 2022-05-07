//
//  Drink.swift
//  Coffee App
//
//  Created by Richie Sun on 4/29/22.
//

import Foundation
import UIKit

struct DrinkResponse: Codable{
    let randomdrinkmatch: Drink
}
struct Drink: Codable{
    let id: Int
    let name: String
    let caffeinemg: Int
    let calories: Int
    let hotorcold: String
}
