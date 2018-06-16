//
//  JSONDataHelper.swift
//  AirAsiaTassk
//
//  Created by Raja Earla on 15/06/18.
//  Copyright © 2018 Raja Earla. All rights reserved.
//

import Foundation

public class JSONDataHelper {
    
//    public func loginData () -> User {
//        let user = loadJson(filename: "Login") as User?
//        return user!
//    }
    
    public func loadJson<T : Codable>(filename fileName: String) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                let jsonData : T = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
