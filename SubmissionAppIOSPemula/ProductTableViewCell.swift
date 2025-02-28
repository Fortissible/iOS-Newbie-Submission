//
//  ProductTableViewCell.swift
//  SubmissionAppIOSPemula
//
//  Created by Wildan on 28/02/25.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewStars: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCurrentPrice: UILabel!
    @IBOutlet weak var productNormalPrice: UILabel!
    @IBOutlet weak var productSold: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
