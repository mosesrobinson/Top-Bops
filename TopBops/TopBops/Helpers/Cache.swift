//
//  Cache.swift
//  TopBops
//
//  Created by Moses Robinson on 5/3/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

class Cache<Key: Hashable, Value> {
    
    func cache(value: Value, for key: Key) {
        queue.async {
            self.cachedItems[key] = value
        }
    }
    
    func value(for key: Key) -> Value? {
        return queue.sync {
            cachedItems[key]
        }
    }
    
    func clear() {
        queue.async {
            self.cachedItems.removeAll()
        }
    }
    
    private var cachedItems: [Key : Value] = [:]
    
    private let queue = DispatchQueue(label: "com.MosesRobinson.TopBops.CacheQueue")
}
