//
//  Network Manager.swift
//  Coffee App
//
//  Created by Richie Sun on 4/29/22.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let host = "http://35.203.114.36"
    
    //Getting and Setting Users
    static func getAllUsers(id: Int, completion: @escaping ([CoffeeUser]) -> Void) {
        let endpoint = "\(host)/preference/match/\(id)/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //Process the response
            switch (response.result) {
            case.success(let data):
                print(data)
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(CoffeeUserResponse.self, from: data) {
                    var result: [CoffeeUser] = []
                    if (userresponse.matches.city != nil){
                        result.append(userresponse.matches.city!)
                    }
                    if (userresponse.matches.flavor != nil){
                        result.append(userresponse.matches.flavor!)
                    }
                    if (userresponse.matches.favoritedrink != nil){
                        result.append(userresponse.matches.favoritedrink!)
                    }
                    completion(result)
                } else{
                    print("Failed to decode getAllPosts")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func login(username: String, password: String, completion: @escaping (Userauth) -> Void) {
        let endpoint = "\(host)/login/"
        let params: [String : String] = [
            "username": username,
            "password": password,
            ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(Userauth.self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode login")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }

        
    }
    
    static func createUser(username: String, password: String, email: String, completion: @escaping (Userauth) -> Void) {
        let endpoint = "\(host)/register/"
        let params: [String : String] = [
            "username": username,
            "password": password,
            "email": email,
            ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(Userauth.self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode createUser")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    static func getUser(id: Int, completion: @escaping (CoffeeUser) -> Void) {
        let endpoint = "\(host)/user/\(id)/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //Process the response
            switch (response.result) {
            case.success(let data):
                print(data)
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(CoffeeUser.self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode getUser")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func deleteUser(username: String, password: String, completion: @escaping (Post) -> Void) {
        
    }
    
    //Getting and Setting Prefs
    
    static func getPrefs(id: Int, completion: @escaping (Preferences) -> Void) {
        let endpoint = "\(host)/preference/\(id)/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //Process the response
            switch (response.result) {
            case.success(let data):
                print(data)
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(Preferences.self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode getPrefs")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    static func createPrefs(id: Int, city: String, age: Int, caffeinemg: Int, maxcalories: Int, hotorcold: String, drinkfav: String, favspot: String, flavors: String, bio: String, matchme: Bool, completion: @escaping (Preferences) -> Void) {
        let endpoint = "\(host)/preferences/\(id)/"
        let params: [String : Any] = [
            "matchme" : matchme,
                "age" : age,
                "city" : city,
                "caffeinemg" : caffeinemg,
                "maxcalories" : maxcalories,
                "hotorcold" : hotorcold,
                "drinkfav" : drinkfav,
                "favspot" : favspot,
                "flavors" : flavors,
                "bio" : bio
            ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(Preferences.self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode createPrefs")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    static func updatePrefs(id: Int, matchme: Bool, age: Int, city: String, caffeinemg: Int, maxcalories: Int, hotorcold: String, drinkfav: String, favspot: String, flavors: String, bio: String, completion: @escaping (Preferences) -> Void) {
        let endpoint = "\(host)/preferences/\(id)/update/"
        let params: [String : Any] = [
            "matchme" : matchme,
                "age" : age,
                "city" : city,
                "caffeinemg" : caffeinemg,
                "maxcalories" : maxcalories,
                "hotorcold" : hotorcold,
                "drinkfav" : drinkfav,
                "favspot" : favspot,
                "flavors" : flavors,
                "bio" : bio
            ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case.success(let data):
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(Preferences.self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode createPrefs")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //Getting and Setting Posts
    static func getAllPosts(completion: @escaping ([Post]) -> Void) {
        let endpoint = "\(host)/get/posts/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //Process the response
            switch (response.result) {
            case.success(let data):
                print(data)
                print("SUCCESS")
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(PostResponse.self, from: data) {
                    completion(userresponse.posts)
                } else{
                    print("Failed to decode getAllPosts")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func createPost(id: Int, content: String, image: String, completion: @escaping (Post) -> Void) {
        let endpoint = "\(host)/posts/\(id)/"
        let params: [String : String] = [
            "content": content,
            "image_data": image
            ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            debugPrint(response)
            switch (response.result) {
            case.success(let data):
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(Post.self, from: data) {
                    completion(userresponse)
                } else{
                    print("Failed to decode createPost")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //Getting Drinks
    static func getDrink(id: Int, completion: @escaping (Drink) -> Void) {
        let endpoint = "\(host)/drink/\(id)/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            //Process the response
            switch (response.result) {
            case.success(let data):
                print(data)
                let jsondecoder = JSONDecoder()
                jsondecoder.dateDecodingStrategy = .iso8601
                if let userresponse = try? jsondecoder.decode(DrinkResponse.self, from: data) {
                    completion(userresponse.randomdrinkmatch)
                } else{
                    print("Failed to decode getDrink")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func convertImage (img: UIImage) -> String {
        let base64 = img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        return "data:image/png;base64," + base64
    }
    
}
