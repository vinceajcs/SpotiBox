//
//  ViewController.swift
//  SpotiBox
//
//  Created by Vincent Stephen Huang on 11/30/17.
//  Copyright © 2017 Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func configureView() {
        LoginManager.shared.delegate = self
        //configureLoginButton()
        //view.backgroundColor = .spotifyBackground
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        LoginManager.shared.login()
    }
    


}

extension ViewController: LoginManagerDelegate {
    func loginManagerDidLoginWithSuccess() {
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewNC")
        dismiss(animated: true, completion: nil)
        //print("***I logged in!")
    }
}

