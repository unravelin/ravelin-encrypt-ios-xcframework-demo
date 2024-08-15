//
//  ViewController.swift
//  RavelinEncryptDemoPods

import UIKit

class ViewController: UIViewController {

    private var useRavelin = UseRavelin(rsaKey: "XXXXXX|YYYYYYYYY")
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        useRavelin.useEncrypt()
    }
}
