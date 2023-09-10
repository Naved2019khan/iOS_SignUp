//
//  VM.swift
//  API Get with ID Practice
//
//  Created by Naved Khan on 22/05/23.
//
import Alamofire
import Foundation
class ViewModel{
    weak var vc : ViewController?
//    let params = register(name : "sdasad", email : "Cee334a@gmail.com",password: "sdaasqw")
    let header : HTTPHeaders = [
        .contentType("application/json")
    ]
    func fetchData(param : register)
    {
        //    let url = "https://jsonplaceholder.typicode.com/todos/"
        
        AF.request("\(base_Url)/register",method: .post,parameters: param,encoder: JSONParameterEncoder.default ,headers: header).response{
            response in
            guard response.value != nil else
            {
                print(response.error!)
                print("fail")
                return
            }
            var msgAlert = "1"
            var titleAlert = ""
            
            
            
            switch response.response?.statusCode
            {
            case 200 :
                msgAlert = "User registration Complete"
                titleAlert = "Success"
            case 400 :
                titleAlert = "Fail Sign Up"
                msgAlert = "Fail due to invalid email"
            case 409 :
                msgAlert = "Email Already Exist"
                titleAlert = "Fail Sign Up"
        
            default :
                break
            }
///          `ALERT`
            self.vc?.alertAction(title : titleAlert , msg : msgAlert, status: response.response?.statusCode ?? 0 )
//            print(response.response?.statusCode)
         
            
        }
    }
}

