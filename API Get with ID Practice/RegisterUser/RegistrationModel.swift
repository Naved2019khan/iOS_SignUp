//
//  Model.swift
//  API Get with ID Practice
//
//  Created by Naved Khan on 22/05/23.
//

import Foundation
struct UsedInfo : Decodable{
    let userId : Int
    let id : Int
    let title : String
    let completed: Bool
}

struct register : Encodable{
    var name : String
    var email : String
    var password : String
}
