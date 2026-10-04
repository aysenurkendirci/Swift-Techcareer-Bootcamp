//
//  ViewController.swift
//  UrunlerApp
//
//  Created by Kübra Kendirci on 12.07.2025.
//


import UIKit


class Anasayfa: UIViewController, UITableViewDelegate, UITableViewDataSource, HucreProtocol {

    @IBOutlet weak var urunlerTableView: UITableView!
    var urunlerListesi = [Urunler]()

    override func viewDidLoad() {
        super.viewDidLoad()

        urunlerTableView.delegate = self
        urunlerTableView.dataSource = self

        let u1 = Urunler(id: 1, ad: "Macbook Pro 14", resim: "bilgisayar", fiyat: 43000)
        let u2 = Urunler(id: 2, ad: "Rayban Club Master", resim: "gozluk", fiyat: 2500)
        let u3 = Urunler(id: 3, ad: "Sony ZX Series", resim: "kulaklik", fiyat: 40000)
        let u4 = Urunler(id: 4, ad: "Gio Armani", resim: "parfum", fiyat: 2000)
        let u5 = Urunler(id: 5, ad: "Casio X Series", resim: "saat", fiyat: 8000)
        let u6 = Urunler(id: 6, ad: "Dyson V8", resim: "supurge", fiyat: 18000)
        let u7 = Urunler(id: 7, ad: "iPhone 13", resim: "telefon", fiyat: 32000)

        urunlerListesi += [u1, u2, u3, u4, u5, u6, u7]
        
        urunlerTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
    }
    func sepetEkleTiklandi(indexPath: IndexPath) {
           let urun = urunlerListesi[indexPath.row]
           print("\(urun.ad!) sepete eklendi")
       }

       // MARK: - Navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toDetay" {
               if let urun = sender as? Urunler {
                   let gidilecekVC = segue.destination as! DetaySayfa
                   gidilecekVC.urun = urun
               }
           }
       }
   }

   // MARK: - TableView Extension
   extension Anasayfa {

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return urunlerListesi.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let hucre = tableView.dequeueReusableCell(withIdentifier: "UrunlerHucre", for: indexPath) as! UrunlerHucre

           let urun = urunlerListesi[indexPath.row]

           hucre.İmageViewUrun.image = UIImage(named: urun.resim!)
           hucre.labelUrunAd.text = urun.ad
           hucre.labelUrunFiyat.text = "\(urun.fiyat!) ₺"
           hucre.backgroundColor = UIColor(white: 0.95, alpha: 1)
           hucre.hucreArkaplan.layer.cornerRadius = 10.0
           hucre.selectionStyle = .none

           hucre.hucreProtocol = self
           hucre.indexPath = indexPath

           return hucre
       }

       func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let urun = urunlerListesi[indexPath.row]

           let silAction = UIContextualAction(style: .destructive, title: "Sil") { _, _, _ in
               print("\(urun.ad!) silindi")
           }

           let duzenleAction = UIContextualAction(style: .normal, title: "Düzenle") { _, _, _ in
               print("\(urun.ad!) düzenlendi")
           }

           return UISwipeActionsConfiguration(actions: [silAction, duzenleAction])
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let urun = urunlerListesi[indexPath.row]
           performSegue(withIdentifier: "toDetay", sender: urun)
       }
       
   }
