//
//  FileUtil.swift
//  iExpire
//
//  Created by Andy Wu on 1/27/23.
//

import Foundation

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    return paths[0]
}

func documentExists(at filename: String) -> Bool {
    return FileManager.default.fileExists(atPath: getDocumentsDirectory().appendingPathComponent(filename).path())
}
