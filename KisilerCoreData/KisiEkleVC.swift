//
//  KisiEkleVC.swift
//  KisilerCoreData
//
//  Created by Kaan Deniz Erikmen on 13.09.2023.
//

import UIKit

class KisiEkleVC: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var txtFKisiTelefon: UITextField!
    @IBOutlet weak var txtFKisiAd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func btnEkle(_ sender: Any) {
        if let ad = txtFKisiAd.text , let tel = txtFKisiTelefon.text {
            let kisi = Kisiler(context: context)
            
            kisi.kisi_ad = ad
            kisi.kisi_tel = tel
            
            appDelegate.saveContext()
        }
        
        
    }
    
}
