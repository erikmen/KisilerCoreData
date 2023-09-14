//
//  KisiDetayVC.swift
//  KisilerCoreData
//
//  Created by Kaan Deniz Erikmen on 13.09.2023.
//

import UIKit

class KisiDetayVC: UIViewController {

    @IBOutlet weak var lblKisi: UILabel!
    @IBOutlet weak var lblKisiTelefon: UILabel!
    @IBOutlet var lblKisiAD: UIView!
    
    var kisi:Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let k = kisi {
            lblKisi.text = k.kisi_ad
            lblKisiTelefon.text = k.kisi_tel
            
        }
        
    }
    



}
