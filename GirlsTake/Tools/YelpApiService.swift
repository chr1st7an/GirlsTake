//
//  YelpApiService.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/29/23.
//

import SwiftUI
import Foundation
import Combine
import CoreLocation

//this will have to be more secure in the future
let apiKey = "OFez66pbNHwCcqlzEcQj9lGpQXTvIJfq_c3cuJV5myWTey1g5sL2DjlnmMgSqB8XcPMsFMucFmH3ZQMiqkRU83s7KVfZ7FQ7kjD8qz8u1iWfH6CBBoB0BLLHiW0kZHYx"

struct YelpApiService{
    //Search term, user location, category
    var search:  (String, CLLocation, String?) -> AnyPublisher<[Business], Never>
}
extension YelpApiService {
    static let live = YelpApiService{ term, location, category in
        // url component for yelp endpoint
        var urlComponent = URLComponents(string: "https://api.yelp.com/v3")!
        urlComponent.path = "/businesses/search"
        urlComponent.queryItems = [
            .init(name:"term", value: term),
            .init(name: "longitude", value: String(location.coordinate.longitude)),
            .init(name: "latitude", value: String(location.coordinate.latitude)),
            .init(name: "categories", value: category ?? "restaurants")
        ]
        let url = urlComponent.url!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        print("working")
        // URL request and return [Businesses]
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .map(\.businesses)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
struct SearchResult: Codable{
    let businesses : [Business]
}

struct Business: Codable{
    let rating:  Double?
    let price, phone, id, alias : String?
    let isClosed: Bool?
    let categories: [Category?]
    let reviewCount: Double?
    let name: String?
    let url: String?
    let coordinates: Coordinates?
    let imageURL: String?
    let location: Location?
    let distance: Double?
    let transactions: [String]?
    enum CodingKeys: String, CodingKey {
        case rating, price, phone, id, alias
        case isClosed = "is_closed"
        case categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageURL = "image_url"
        case location, distance, transactions
    }
}
struct Category: Codable {
    let alias, title: String?
}
struct Coordinates: Codable {
    let latitude, longitude: Double?
}

struct Location: Codable{
    let city, country, address2, address3: String?
    let state, address1, zipCode: String?
    enum CodingKeys: String, CodingKey {
        case city, country, address2, address3, state, address1
        case zipCode = "zip_code"
        
    }
}
