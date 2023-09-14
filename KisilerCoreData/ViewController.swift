//
//  ViewController.swift
//  KisilerCoreData
//
//  Created by Kaan Deniz Erikmen on 13.09.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var kisilerTableView: UITableView!
    
    var kisilerListe = [Kisiler]()
    var aramaYapiliyorMu = false
    var aramaKelimesi:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self

        searchBar.delegate = self
        }
    
    override func viewWillAppear(_ animated: Bool) {
        if aramaYapiliyorMu{
            AramaYap(kisi_ad: aramaKelimesi!)
        }else{
            tumKisilerAl()
        }
        
        
        
        kisilerTableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        
        
        if segue.identifier == "toDetay"{
            let gidilecekVC = segue.destination as! KisiDetayVC
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
        
        if segue.identifier == "toGuncelle"{
            let gidilecekVC = segue.destination as! KisiGuncelleVC
            gidilecekVC.kisi = kisilerListe[indeks!]

        }
    }
    
    func tumKisilerAl(){
        do {
            kisilerListe =  try context.fetch(Kisiler.fetchRequest())
        } catch  {
            print(error)
        }
    }
    
    func AramaYap(kisi_ad:String){
        let fetchRequest:NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "kisi_ad CONTAINS %@", kisi_ad)
        do {
            kisilerListe =  try context.fetch(fetchRequest)
        } catch  {
            print(error)
        }
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisi = kisilerListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! kisiHucreTableViewCell
        
        cell.lblKisiAlan.text = "\(kisi.kisi_ad!) - \(kisi.kisi_tel!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){(contextualAction,view,boolValue) in
            
            let kisi = self.kisilerListe[indexPath.row]
            self.context.delete(kisi)
            
            appDelegate.saveContext()
            if self.aramaYapiliyorMu{
                self.AramaYap(kisi_ad: self.aramaKelimesi!)
            }else{
                self.tumKisilerAl()
            }
            
            self.kisilerTableView.reloadData() 
        }
        
        let guncelleAction = UIContextualAction(style: .normal, title: "Güncelle"){(contextualAction,view,boolValue) in
            
            
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [silAction,guncelleAction])
     }
}

extension ViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        aramaKelimesi = searchText
        
        if searchText == ""{
            aramaYapiliyorMu = false
            tumKisilerAl()
        }else{
            aramaYapiliyorMu = true
            AramaYap(kisi_ad: aramaKelimesi!)
        }
        
        
        kisilerTableView.reloadData()
    }
    
}
