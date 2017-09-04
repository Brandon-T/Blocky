//
//  ViewController.swift
//  Blocky
//
//  Created by Brandon on 2017-09-04.
//  Copyright © 2017 Brandon. All rights reserved.
//

import Foundation

class SomeClass : NSObject {
    
    @objc
    func foo(arg: Any) {
        print("FUNC \(arg)")
    }

    func test() {
        let blocky: @convention(block) (Any) -> Void = {(arg) in
            print("BLOCK \(arg)")
        }
        
        
        var function = BlockFunction<Void>(blocky)
        try! function.execute(args: 9)
        
        
        function = BlockFunction<Void>(self, function: #selector(SomeClass.foo))
        try! function.execute(args: 10)
    }
}

