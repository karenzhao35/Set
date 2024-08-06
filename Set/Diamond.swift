//
//  Diamond.swift
//  Set
//
//  Created by Karen Zhao on 2024-08-01.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: 10, y: 10))
        
//        p.move(to: CGPoint(x: 100, y: 50))
//        p.addLine(to: CGPoint(x: 200, y: 100))
//
//        p.move(to: CGPoint(x: 100, y: 100))
//        p.addLine(to: CGPoint(x: 200, y: 100))
        
        return p
    }
    
    
}
