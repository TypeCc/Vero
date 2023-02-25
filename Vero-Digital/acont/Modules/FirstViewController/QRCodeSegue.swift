//
//  ViewController.swift
//  acont
//
//  Created by serif mete on 8.02.2023.
//


import UIKit

final class QRCodeSegueController: UIViewController {
    
    //MARK: - My Variable
    
    @IBOutlet weak var LBL: UILabel!
    
    //MARK: - My Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func tapToScan(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


