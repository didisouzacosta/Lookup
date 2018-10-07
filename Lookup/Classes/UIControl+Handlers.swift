//
//  UIControl+Handlers.swift
//  Lookup
//
//  Created by Adriano Costa on 06/10/18.
//

import Foundation
import UIKit

private class ClosureSleeve {
    
    let closure: () -> Void
    
    init (_ closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
    
}

extension UIControl {
    
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping () -> Void) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, UUID().uuidString, sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
}
