//
//  Invocable.swift
//  Blocky
//
//  Created by Brandon on 2017-09-04.
//  Copyright © 2017 Brandon. All rights reserved.
//

import Foundation

protocol Invocable {
    func execute(_ args: AnyObject?...) throws -> AnyObject?
    func execute(_ args: [AnyObject?]) throws -> AnyObject?
}
