//
//  Function.swift
//  Blocky
//
//  Created by Brandon on 2017-09-04.
//  Copyright © 2017 Brandon. All rights reserved.
//

import Foundation

class BlockFunction<T> {
    private let ptr: Invocable!
    
    init<Func>(_ block: Func) {
        self.ptr = Block(block)
    }
    
    init(_ instanceObject: AnyObject, function: Selector) {
        self.ptr = Func(instanceObject, selector: function)
    }
    
    func execute(args: [AnyObject]) throws -> T {
        let result = try BlockFunction.cast(from: self.ptr.execute(args)) as T;
        
        if T.self == Void.self {
            return Void() as! T
        }
        
        return result
    }
    
    func execute(args: AnyObject...) throws -> T {
        let result = try BlockFunction.cast(from: self.ptr.execute(args)) as T;
        
        if T.self == Void.self {
            return Void() as! T
        }
        
        return result
    }
    
    
    
    private class func cast<T>(from v: Any?)-> T {
        if T.self == Void.self {
            return Void() as! T
        }
        return v as! T
    }
    
    private class func cast<T>(from v: Any?) -> T where T: ExpressibleByNilLiteral {
        guard let v = v else { return nil }
        return v as! T
    }
}

class Function<T> {
    private let ptr: () throws -> T
    
    init<Func>(_ block: Func, args: [AnyObject]) {
        self.ptr = {() throws -> T in
            let result = try Function.cast(from: Block(block).execute(args)) as T;
            
            if T.self == Void.self {
                return Void() as! T
            }
            
            return result
        }
    }
    
    convenience init<Func>(_ block: Func, args: AnyObject...) {
        self.init(block, args: args)
    }

    func execute() throws -> T {
        return try self.ptr() 
    }
    
    
    
    private class func cast<T>(from v: Any?)-> T {
        if T.self == Void.self {
            return Void() as! T
        }
        return v as! T
    }
    
    private class func cast<T>(from v: Any?) -> T where T: ExpressibleByNilLiteral {
        guard let v = v else { return nil }
        return v as! T
    }
}


postfix operator ^
postfix func ^ <T>(function: Function<T>) throws -> T {
    return try function.execute()
}
