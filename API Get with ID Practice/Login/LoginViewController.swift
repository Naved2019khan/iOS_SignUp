//
//  LoginLoginViewController.swift
//  API Get with ID Practice
//
//  Created by Naved Khan on 23/05/23.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController{
    /// `Label` Outlets
    @IBOutlet weak var labelSignIn: UILabel!
    @IBOutlet weak var labelDont: UILabel!
    /// `View` Outlets
    @IBOutlet weak var viewForm: UIView!
    
    /// `TextFields` Outlets
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    ///     ` Local Variable `
    var gradientLayerArray = Array.init(repeating: CAGradientLayer(), count: 2)
    
    //    let logout = LogOutViewController()
    var dataToken = String()
    static let loginVc = LoginViewController()
    let userDef = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        
        loadingView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(addActionTap))
        labelDont.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        byDefaultLogin()
    }
    
    
    /// `Button` Outlets
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        if  email.text == nil || password.text == nil
        {
            return
        }
        
        let sendData = Login(login: email.text!, password: password.text!)
        
        fetchData(param: sendData)
        
    }
}

extension LoginViewController: UITextFieldDelegate{
///    `Sign Up Navigation`
    @objc func addActionTap() {
        let vc = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    /// `Alert`
    /// `Navigation`
    func alertAction(title : String , msg : String,token : String?)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        self.present(alert, animated: true, completion: nil )
        if token != nil{
            self.dismiss(animated: true, completion: { [self]   in
                let vc = storyboard?.instantiateViewController(identifier: "LogOutViewController") as! LogOutViewController
//                vc.data = userDef.value(forKey:  "userLogoutToken" ) as! String
                navigationController?.pushViewController(vc, animated: true)
            })
        }
    }
    
    func byDefaultLogin() {
        if userDef.value(forKey:  "userLogoutToken" ) != nil
        {
            let vc = storyboard?.instantiateViewController(identifier: "LogOutViewController") as! LogOutViewController
//                vc.data = userDef.value(forKey:  "userLogoutToken" ) as! String
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /// `TextField`
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var tg = textField.tag
        switch textField {
        case email:
            tg = 0
        case password:
            tg = 1
        default:
            break
        }
        //        textField.text!.count <= 1
        if string == "" &&   textField.tag == tg  && range.upperBound == 1  {
            //            gradientLayer[tg].removeFromSuperlayer()
            gradientLayerArray[tg].removeFromSuperlayer()
        }
        else if textField.tag == tg {
            gradientLayerArray[tg].removeFromSuperlayer()
            addBottomBorder(textField.viewWithTag(textField.tag)!,tg)
        }
        return true
    }
    
    func loadingView(){
        password.isSecureTextEntry = true
        viewForm.layer.cornerRadius = 25
        btnSignIn.layer.cornerRadius = 12
        labelSignIn.bottomLine()
        labelDont.halfTextColorChange(fullText: "Already have an account? Sign Up", changeText: "Sign Up", colorTo : UIColor.systemBlue)
        btnSignIn.addShadow()
    }
}

extension LoginViewController {
    func addBottomBorder(_ views : UIView,_ tg : Int){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: views.frame.size.height - 1, width: views.frame.size.width, height: 1)
        gradientLayer.colors = [UIColor(red: 2/255, green: 0/255, blue: 26/255, alpha: 1).cgColor,
                                CGColor(red:118/255, green: 118/255, blue: 196/255, alpha: 1),
                                CGColor(red: 0, green: 212/255, blue: 1, alpha: 1)
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        views.layer.addSublayer(gradientLayer)
        gradientLayerArray[tg] =  gradientLayer
    }
}

extension LoginViewController{
    func fetchData(param : Login)
    {
        //    let url = "https://jsonplaceholder.typicode.com/todos/"
        AF.request("\(base_Url)/login",method: .post,parameters: param,encoder: JSONParameterEncoder.default ).responseDecodable(of: ResponseData.self){
            [self]  response in
            guard let data = response.value  else
            {
                print(response.error!)
                alertAction(title: "Fail Sign In", msg: "Fail due to invalid email or password" , token: nil )
                print("fail")
                return
            }
            var msgAlert = ""
            var titleAlert = ""
            switch response.response?.statusCode
            {
            case 200 :
                msgAlert = "User Login Complete"
                titleAlert = "Success"
                userDef.set(data.userToken, forKey: "userLogoutToken")
                alertAction(title : titleAlert , msg : msgAlert , token : data.userToken )
                
            case 400 :
                titleAlert = "Fail Sign In"
                msgAlert = "Fail due to invalid email or password"
                
            default :
                break
            }
            print(response.response?.statusCode ?? 0)
        }
        
        
    }
}


