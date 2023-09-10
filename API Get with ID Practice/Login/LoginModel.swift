//
//  LoginModel.swift
//  API Get with ID Practice
//
//  Created by Naved Khan on 24/05/23.
//

import Foundation

struct Login :Encodable
{
    let login : String
    let password : String
}

struct ResponseData : Decodable{
    
    let lastLogin: Int?
    let userStatus: String
    let created: Int
    let accountType: String
    let ownerId: String
    let socialAccount: String
    //let oAuthIdentities: null,
    let name: String
    let classes: String
   
    let userToken: String
    //let updated: null,
    let email: String
    let objectId: String
    enum CodingKeys : String ,CodingKey{
        case lastLogin
        case userStatus
        case created
        case accountType
        case ownerId
        case socialAccount
        case name
        case userToken = "user-token"
        case classes = "___class"
        case email
        case objectId
    }
    
}
