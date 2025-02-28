//
//  DetailViewController.swift
//  SubmissionAppIOSPemula
//
//  Created by Wildan on 28/02/25.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var productDetailDesc: UILabel!
    @IBOutlet weak var productDetailImage: UIImageView!
    @IBOutlet weak var productDetailSold: UILabel!
    @IBOutlet weak var productDetailReview: UILabel!
    @IBOutlet weak var productDetailNormalPrice: UILabel!
    @IBOutlet weak var productDetailCurrentPrice: UILabel!
    @IBOutlet weak var productDetailName: UILabel!
    
    var productDetail: ProductModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let result = productDetail {
            productDetailDesc.text = "Lorem Ipsum Dolor Sit Amet"
            productDetailImage.image = result.uiImage
            productDetailSold.text = "\(result.sold ?? 0) Terjual | "
            productDetailReview.text = "\(result.sold == nil ? 0.0 : 5.0) Rating"
            productDetailName.text = result.title
            if result.discount {
                let attrStr = NSAttributedString(
                    string: "Rp.\(result.discounted_price!)",
                    attributes: [
                        .strikethroughStyle: NSUnderlineStyle.single.rawValue
                    ]
                )
                
                productDetailCurrentPrice.text = "Rp.\(result.price)"
                productDetailNormalPrice.attributedText = attrStr
            } else {
                productDetailNormalPrice.text = "No Discount Available"
                productDetailCurrentPrice.text = String(result.price)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
