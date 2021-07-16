//
//  ViewController.swift
//  RavelinCoreDemoSPM

import UIKit

class ViewController: UIViewController {

    private var useRavelin = UseRavelin(apiKey: "publishable_key_xxx", rsaKey: "XXXXXX|YYYYYYYYY")
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        useRavelin.useCore()
        useRavelin.useEncrypt()
    }
}
