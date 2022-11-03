//
//  SubscriptExample.swift
//  SeSACWeek18
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation

extension String {
    
    // jack >>>> [1] >>>> a
    subscript(idx: Int) -> String? {
        
        guard (0..<count).contains(idx) else {
            return nil
        }
        
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
    
}

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}

// let a = [Phone(), Phone()]
// Phone[1]
// 구조체 내에서도 확장해서 쓸 수 있음
struct Phone {
    var numbers = ["1234", "5678", "3353", "2222"]
    
    subscript(idx: Int) -> String {
        get {
            return self.numbers[idx]
        }
        set {
            self.numbers[idx] = newValue
        }
    }
}


