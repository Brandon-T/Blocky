# Blocky
A Swift Block Implementation

This framework lets you call functions at runtime with any amount of arguments (an array or variadic parameter pack). 
You can also execute blocks at runtime.

Instead of having to always specify a block or function signature when storing it as a property, you can store a `BlockFunction`
instead.



Usage:

````Swift
import Foundation

class SomeClass : NSObject {

    func test() {
        let blocky: @convention(block) (Int) -> Void = {(arg) in
            print("BLOCK \(arg)")
        }
        
        
        var function = BlockFunction<Void>(blocky)
        try! function.execute(args: 9)
    }
}
````


OR

````Swift
import Foundation

class Something : NSObject {

    @objc
    func funky(arg: Int) {
       print("BLOCK \(arg)")
    }

    func test() {
        var function = BlockFunction<Void>(self, #selector(Something.funky:))
        try! function.execute(args: 9)
    }
}
````
