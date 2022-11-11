//
//  HierarchicalValue.swift
//  
//
//  Created by Vaida on 11/12/22.
//


indirect enum HierarchicalValue {
    
    case value(String)
    
    case stratum([HierarchicalValue])
    
    case empty
    
}
