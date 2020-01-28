//
//  ViewController.swift
//  Exisit-Remote-iOS
//
//  Created by Quadrant Apple on 1/3/20.
//  Copyright © 2020 Quadrant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
@IBAction func loginButton(sender: AnyObject) {
    NSLog("login ok")
    let _login = "loginText.text"
    let _password = "passwordText.text"

    if(_login.isEmpty || _password.isEmpty){
        var alert:UIAlertView = UIAlertView()
        alert.title = "Error"
        alert.message = "Entrez vos identifiants"
        alert.delegate = self
        alert.addButtonWithTitle("OK")
        alert.show()
    } else{
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/connexion/login")!)
    request.HTTPMethod = "POST"
    let params = ["login": _login, "pass": _password]
    do {
        let data = try NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
        request.HTTPBody = data
    } catch let error as NSError {
        print("json error: \(error.localizedDescription)")
    }

    let loginTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
        guard let data = data, let _ = response  where error == nil else {
            print("error")
            return
        }

        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            print(json)
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
    })
    loginTask.resume()
    }
}

}

