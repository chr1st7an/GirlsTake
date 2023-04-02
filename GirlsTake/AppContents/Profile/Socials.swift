//
//  Socials.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/13/23.
//

import SwiftUI

struct Socials: View {
    var active:  Bool
    var url : URL
    var icon : String
    init(url: String, active: Bool) {
        guard let urll = URL(string: url) else {
            self.icon = "Instagram"
            self.url = URL(fileURLWithPath: "Events")
            self.active = active
            return }
        self.active = active
        self.url = urll
        
        self.icon = getSocial(url: url)
    }
    
    var body: some View {
        if active{
            Link(destination: self.url)
            {
                Image(self.icon).resizable().frame(width: 30, height: 30).foregroundColor(.gray)
            }
        }else{
            Image(self.icon).resizable().frame(width: 30, height: 30).foregroundColor(.gray)
        }
    }
}

func getSocial(url: String) ->String{
    if url.localizedCaseInsensitiveContains("Instagram"){
        return "Instagram"
    } else if url.localizedCaseInsensitiveContains("TikTok"){
        return "TikTok"
    }else if url.localizedCaseInsensitiveContains("Pinterest"){
        return "Pinterest"
    }else{
        return "Twitter"
    }
}

