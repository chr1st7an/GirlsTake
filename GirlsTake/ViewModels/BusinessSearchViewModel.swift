//
//  BusinessSearchViewModel.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/29/23.
//

import SwiftUI
import Foundation
import Combine

final class BusinessSearchViewModel: ObservableObject {
    @Published var businesses = [Business]()
    @Published var searchText = ""
    func search(){
        let live = YelpApiService.live
        live.search("food", .init(latitude: 42.36, longitude: -71), nil)
            .assign(to: &$businesses)
    }

}
