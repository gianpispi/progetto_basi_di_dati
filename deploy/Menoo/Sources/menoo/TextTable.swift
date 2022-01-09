//
//  TextTable.swift
//  
//
//  Created by Gianpiero Spinelli on 07/01/22.
//

import Rainbow

class TextTable {
    class func print(header: [String], body: [[String?]?], limit: Int = 0) {
        let body = body.compactMap({ $0 })
        
        for i in body {
            if i.count != header.count {
                Swift.print("There is a row with a non matching number of parameters")
                return
            }
        }
        
        var lengths = [Int]()
        var s = ""
        
        s += "|".bold
        for (index, headTitle) in header.enumerated() {
            var length = max(body.map({ $0[index] ?? "" }).max(by: {$1.count > $0.count})?.count ?? 0, headTitle.count)
            
            if limit > 0 {
                length = min(length, limit)
            }
            
            lengths.append(length)
            
            if limit > 0 {
                if length < headTitle.count {
                    s += (String(headTitle.prefix(length - 1)) + "…").bold
                } else {
                    s += String(headTitle.prefix(length)).bold
                }
            } else {
                s += headTitle.bold
            }
            
            if length - headTitle.count > 0 {
                s += String(repeating: "_".bold, count: length - headTitle.count)
            }
            
            s += "|".bold
        }
        
        s += "\n"
        
        for row in body {
            s += "|"
            for (index, col) in row.enumerated() {
                let col = col ?? ""
                
                if limit > 0 {
                    if lengths[index] < col.count {
                        s += (String(col.prefix(lengths[index] - 1)) + "…")
                    } else {
                        s += String(col.prefix(lengths[index]))
                    }
                } else {
                    s += col
                }
                
                if lengths[index] - col.count > 0 {
                    s += String(repeating: "_", count: lengths[index] - col.count)
                }
                
                s += "|"
            }
            s += "\n"
        }
        
        Swift.print(s)
    }
}
