//
//  LogOutViewController.swift
//  API Get with ID Practice
//
//  Created by Naved Khan on 24/05/23.
//

import UIKit
import Alamofire
class LogOutViewController: UIViewController{
    
    @IBOutlet weak var viewForm: UIView!
    @IBOutlet weak var labelLogOut: UILabel!
    @IBOutlet weak var viewLogOut: UIView!
    
//    for use default in loginVC
    var loginVc = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(addAction))
        viewLogOut.addGestureRecognizer(tap)
        viewForm.layer.cornerRadius = 25
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension LogOutViewController{
    
    @objc func addAction(){
        if  loginVc.userDef.value(forKey: "userLogoutToken") != nil
        {
            let header : HTTPHeaders = [
                "user-Token" :  loginVc.userDef.value(forKey: "userLogoutToken") as! String
            ]
            AF.request(base_Url+"logout",method: .get, headers: header).response{ [self]  response in
                switch response.result {
                case .success(let data ):
                    print(data as Any)
                    loginVc.userDef.removeObject(forKey: "userLogoutToken")
                    alertMessage()
                    print("Successful log out")
                case .failure(let err):
                    print(err)
                    print(response.response?.statusCode ?? 0)
                }
            }
        }
        else{
            print("No key")
        }
    }
    
    func alertMessage(){
        let alert = UIAlertController(title: "Logout successful", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
