import Foundation


class Fixtures: NSObject {
    static func getJSON(jsonPath: String) -> String? {
        guard let data = getJSONData(jsonPath: jsonPath) as Data? else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    static func getJSONData(jsonPath: String) -> Data? {
        return getData(filePath: jsonPath, ofType: "json")
    }
    
    static func getHTML(htmlPath: String) -> String? {
        guard let data = getHTMLData(htmlPath: htmlPath) as Data? else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    static func getHTMLData(htmlPath: String) -> NSData? {
        return getData(filePath: htmlPath, ofType: "html") as NSData?
    }
    
    static func getData(filePath: String, ofType: String) -> Data? {
        guard let path = Bundle(for: Fixtures.self).path(forResource: filePath, ofType: ofType),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                NSLog("************* No Fixture found with name '\(filePath).\(ofType)', did you add it to the fixtures? *************")
                return nil
        }
        
        return data
    }
}
