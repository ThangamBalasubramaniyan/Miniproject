//
//  itemTableViewCell.swift
//  MiniProject
//
//  Created by user199474 on 7/2/21.
//

import UIKit

class itemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var loginLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}






//    func downloadImg(with Item: itemTableViewCell) {
//        let data = Item.imgView
//        let urlRequest = URLRequest(url: URL(string: url)!)
//        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if error != nil {
//                print(error)
//                return
//            }
//            DispatchQueue.main.async {
//                self.imgView = UIImageView(data: )
//            }
//        }
//        task.resume()
//    }
//
//}
