//
//  UrunlerHucre.swift
//  UrunlerApp
//
//  Created by Kübra Kendirci on 12.07.2025.
//

import UIKit

protocol HucreProtocol: AnyObject {
    func sepetEkleTiklandi(indexPath: IndexPath)
}

class UrunlerHucre: UITableViewCell {

    
    @IBOutlet weak var hucreArkaplan: UIView!
    
    @IBOutlet weak var labelUrunAd: UILabel!
    
    @IBOutlet weak var labelUrunFiyat: UILabel!
     
    var hucreProtocol:HucreProtocol?
    var indexPath:IndexPath?
    
    @IBOutlet weak var İmageViewUrun: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttonSepeteEkle(_ sender: Any) {
        if let index = indexPath {
            hucreProtocol?.sepetEkleTiklandi(indexPath: index)
        }
    }

}
