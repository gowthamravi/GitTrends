//
//  Utils.swift
//  GitTrendsTests
//
//  Created by Ravikumar, Gowtham.
//

import Foundation

class Utils {
    static func readJSONFromFile<T: Decodable>(fileName: String, type: T.Type) -> T? {
        let bundle = TestBundleFind.bundle
        if let url = bundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

private class TestBundleFind {
    static var bundle: Bundle {
        return Bundle(for: self)
    }
}
