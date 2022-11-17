//
//  Animation.swift
//  
//
//  Created by Vaida on 11/17/22.
//


import Foundation


/// The keyframe animation of an explicit change from its original state to `destination`.
public struct Animation {
    
    let name: String
    
    let duration: Double
    
    let delay: Double?
    
    let destination: StyleSheet
    
    public init(name: String? = nil, duration: Double = 1, delay: Double? = nil, destination: StyleSheet) {
        self.name = name ?? UUID().uuidString.replacingOccurrences(of: "-", with: "")
        self.duration = duration
        self.delay = delay
        self.destination = destination
    }
    
    public init(name: String? = nil, duration: Double = 1, delay: Double? = nil, destination: () -> StyleSheet) {
        self.init(name: name, duration: duration, delay: delay, destination: destination())
    }
    
}
