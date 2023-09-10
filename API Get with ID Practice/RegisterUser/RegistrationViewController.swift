//
//  ViewController.swift
//  API Get with ID Practice
//
//  Created by Naved Khan on 22/05/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var labelSignUp: UILabel!
    let vm = ViewModel()
    
    @IBOutlet weak var viewForm: UIView!
    @IBOutlet weak var labelAlready: UILabel!
    @IBOutlet weak var btnSignUp: UIButton!
    
    /// `TextFields` Outlets
    
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    var gradientLayerArray = Array.init(repeating: CAGradientLayer(), count: 4)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fName.delegate = self
        lName.delegate = self
        email.delegate = self
        password.delegate = self
        vm.vc = self
        loadingView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(addActionTap))
        labelAlready.addGestureRecognizer(tap)
        //        vm.fetchData()
    }
    
    @objc func addActionTap() {
        let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        if fName.text == nil || lName.text == nil || email.text == nil || password.text == nil
        {
            return
        }
        
        let sendData = register(name: fName.text! + lName.text!, email: email.text!, password: password.text!)
        vm.fetchData(param: sendData)
    }
    
    
    
}

extension ViewController: UITextFieldDelegate{
    
    /// `Alert`
    func alertAction(title : String , msg : String , status : Int)
    {
//        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
        if status == 200
        {
            let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /// `TextField`
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var tg = textField.tag
        switch textField {
        case fName:
            tg = 0
        case lName:
            tg = 1
        case email:
            tg = 2
        case password:
            tg = 3
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
        btnSignUp.layer.cornerRadius = 12
        labelSignUp.bottomLine()
        labelAlready.halfTextColorChange(fullText: "Already have an account? Sign In", changeText: "Sign In", colorTo : UIColor.systemBlue)
        btnSignUp.addShadow()
    }
    
}
extension ViewController {
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

extension UILabel{
    func bottomLine(){
        let gradientLayer = CALayer()
        gradientLayer.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width/2, height: 2)
        gradientLayer.backgroundColor =  UIColor.white.cgColor
        self.layer.addSublayer(gradientLayer)
    }
    func halfTextColorChange (fullText : String , changeText : String, colorTo : UIColor ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute( .foregroundColor, value: colorTo , range: range)
        self.attributedText = attribute
    }
}


extension UIButton{
    func addShadow(){
        self.layer.shadowColor = UIColor.systemBlue.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
}
