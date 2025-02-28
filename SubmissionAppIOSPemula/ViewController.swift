//
//  ViewController.swift
//  SubmissionAppIOSPemula
//
//  Created by Wildan on 28/02/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    
    var products: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            loadData()
        }
        
        // Do any additional setup after loading the view.
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.register(
            UINib(nibName: "ProductTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ProductCell"
        )
    }
    
    private func loadData() {
        if let loadedProducts = loadProductsFromJSON() {
            for product in loadedProducts {
                print("Product ID: \(product.id), Title: \(product.title), Price: \(product.price)")
            }
            products = loadedProducts
            productTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell {
            
            let product = products[indexPath.row]
            
            cell.productName.text = product.title
            cell.reviewStars.text = "\(product.sold == nil ? 0.0 : 5.0) | "
            cell.productSold.text = "\(product.sold ?? 0) Sold"
            cell.productImage.image = product.uiImage
            
            if product.discount {
                let attrStr = NSAttributedString(
                    string: "Rp.\(product.discounted_price!)",
                    attributes: [
                        .strikethroughStyle: NSUnderlineStyle.single.rawValue
                    ]
                )
                
                cell.productCurrentPrice.text = "Rp.\(product.price)"
                cell.productNormalPrice.attributedText = attrStr
            } else {
                cell.productNormalPrice.text = "No Discount Available"
                cell.productCurrentPrice.text = String(product.price)
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        performSegue(withIdentifier: "moveToProductDetail", sender: products[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToProductDetail" {
            if let detailViewController = segue.destination as? DetailViewController{
                detailViewController.productDetail = sender as? ProductModel
            }
        }
    }
}
