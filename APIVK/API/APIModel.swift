//
//  APIModel.swift
//  APIVK
//
//  Created by Danil Komarov on 24.03.2023.
//

import Foundation

struct Friends: Decodable {
    let id: Int
    let photo50: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo50 = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
