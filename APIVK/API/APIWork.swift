//
//  APIWork.swift
//  APIVK
//
//  Created by Danil Komarov on 24.03.2023.
//

import Foundation
import Alamofire

final class APIWork {
    
    static let shared = APIWork()
    
    func componentsFrendsGet(complition: @escaping ([Friends]) -> Void) {
        let url = "https://api.vk.com/method/friends.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "fields": "photo_50",
            "v": "5.131",
            "count": 30
        ]
        
        AF.request(url, method: .post, parameters: params).responseData { [weak self] (response) in
            guard let data = response.data else {return}
            
            do {
                
                let friendsResponse = try JSONDecoder().decode(VKResponce<Friends>.self, from: data)
                complition(friendsResponse.items)
//                print(friendsResponse)
            }catch{
                print(error)
            }
        }
    }
    
    func componentsPhotosGet(token: String) {
        let url = "https://api.vk.com/method/photos.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "album_id": "profile",
            "v": "5.131",
            "count": 5
        ]
        
        AF.request(url, method: .post, parameters: params).responseData { (response) in
            print(response.value)
        }
    }
}
