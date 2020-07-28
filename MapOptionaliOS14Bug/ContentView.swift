//
//  ContentView.swift
//  MapOptionaliOS14Bug
//
//  Created by Jeremy Gale on 2020-07-28.
//  Copyright © 2020 Jeremy Gale. All rights reserved.
//

import SwiftUI

struct Object: Identifiable {
    var id: String
}

struct ContentView: View {
    @State var objects = [
        Object(id: "1"),
        Object(id: "2"),
        Object(id: "3"),
        Object(id: "4"),
        Object(id: "5")
    ]
    @State var tappedObject: Object?
    @State var showSheet = false
                
    var body: some View {
        List {
            ForEach(objects) { object in
                Text(object.id)
                    .onTapGesture {
                        self.tappedObject = object
                        self.showSheet = true
                    }
            }
            .sheet(isPresented: self.$showSheet) {
                self.tappedObject.map {
                    Text($0.id)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
