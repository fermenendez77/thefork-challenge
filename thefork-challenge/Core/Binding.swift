//
//  Binding.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import Foundation

final class Binding<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
