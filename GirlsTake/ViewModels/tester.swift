//
//  tester.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/29/23.
//

import SwiftUI

struct tester: View {
    @ObservedObject var businessView = BusinessSearchViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(businessView.businesses, id: \.id){ business in
                    Text(business.name ?? "no name")
                }
            }
            .listStyle(.plain)
            .onAppear(perform: businessView.search)
        }
    }
}
