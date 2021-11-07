//
//  Sequence+Sorted.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 06/11/2021.
//

import Foundation

extension Sequence {
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>,
                               _ comparator : (T,T) -> Bool = (>)) -> [Element] {
        return sorted { first, second in
            return comparator(first[keyPath: keyPath], second[keyPath: keyPath])
        }
    }
}
