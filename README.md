I've made a GitHub repo that reproduces the example: https://github.com/jgale/MapOptionaliOS14Bug. I've also attached a .zip here and a screen recording of the bug, and pasted the code inline. I've filed a bug with Apple: FB8196917

# Steps to Reproduce

Create a `List` of `Object` with a `onTapGesture` that sets a `@State var tappedObject: Object?` variable. In the `.sheet()` map on that object and present it it's not nil.


```swift
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
```

Run the app and tap on any row.

Expected: 
* It will present a sheet that will show that object's ID.

Actual:
* It works properly on iOS 13
* On iOS 14, the first tap you tap an object, the sheet is completly empty. Sometimes the first few times you try it, it doesn't work and then it eventually starts working. In the screen recording, the first two tries did not work and the third try did.


I've seen others mention this bug on the Apple forms and a Developer Tools Engineer suggested filing a Feedback:
https://developer.apple.com/forums/thread/650818

# Workarounds

I've switched to the `sheet(item:onDismiss:content:)` API which works properly with optional state objects.