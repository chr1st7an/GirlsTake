//
//  CalendarView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/5/23.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        //Add calendar ui (weekly or monthly) linked to user-registered events
        VStack{
            Header()
            Spacer()
            Text("events")
            
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
