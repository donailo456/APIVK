//
//  Session.swift
//  APIVK
//
//  Created by Danil Komarov on 24.03.2023.
//

import Foundation

class Session {
    static let shared = Session()
    private init() {}
    
    var token: String = ""
}
