//
//  Dynamic.swift
//  Lookup
//
//  Created by Adriano Costa on 06/10/18.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
            fire(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        fire(value)
    }
    
    func fire(_ value: T) {
        if Thread.isMainThread {
            listener?(value)
        } else {
            DispatchQueue.main.async {
                self.listener?(value)
            }
        }
    }
    
}
