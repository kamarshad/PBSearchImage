//
//  DynamicType.swift
//  PBSearchImage
//
//  Created by Mohammad Kamar Shad on 9/24/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

typealias CompletionHandler = (() -> Void)

class DynamicType<T> {
    private var observers = [String: CompletionHandler]()
    
    var value: T {
        didSet {
            notify()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        addObserver(observer, completionHandler: completionHandler)
        notify()
    }
    
    private func notify() {
        observers.forEach { $0.value() }
    }
    
    deinit {
        observers.removeAll()
    }
}
