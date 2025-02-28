//
//  ProductModel.swift
//  SubmissionAppIOSPemula
//
//  Created by Wildan on 28/02/25.
//

import Foundation
import UIKit

struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Int
    let discounted_price: Int?
    let discount: Bool
    let sold: Int?
    let image: String
    
    var uiImage: UIImage? {
        return UIImage(named: image)
    }
    
}

func loadProductsFromJSON() -> [ProductModel]? {
    guard let url = Bundle.main.url(forResource: "data", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        print("Error loading JSON file")
        return nil
    }

    let decoder = JSONDecoder()
    do {
        let products = try decoder.decode([ProductModel].self, from: data)
        return products
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}
