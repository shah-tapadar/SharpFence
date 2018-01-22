//
//  FileManager.swift
//  SharpFence
//
//  Created by Sebin on 22-01-2018.
//  Copyright © 2018 Rapid Value. All rights reserved.
//

import Foundation

class FileManagerWrapper: NSObject {
    
    static func writeFile(fileName: String, content: String) {
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        print("FilePath: \(fileURL.path)")
    do {
            // Write to the file
            try content.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }
    
    static func getFilePath(fileName: String) -> URL{
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
    }
}
