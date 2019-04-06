//
//  XMLSimpleParser.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 25/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

internal final class XMLParserDictionaryAdapter: NSObject, XMLParserDelegate {
    
    internal let entityName: String
    internal let entityElements: [String]
    internal let data: Data
    
    /// the current dictionary
    private var currentDictionary: [String: String]!
    private var currentValue: String?
    private var parser: XMLParser
    /// the whole array of dictionaries
    private var results: [[String: String]]
    
    internal init(data: Data, entityName: String, entityElements: [String]) {
        self.entityName = entityName
        self.entityElements = entityElements
        self.data = data
        self.parser = XMLParser(data: data)
        self.results = []
    }
    
    internal func getResults() throws -> [[String: String]] {
        parser.delegate = self
        if !parser.parse(), let error = parser.parserError {
            throw error
        }
        return results
    }
    
    // start element
    //
    // - If we're starting a "record" create the dictionary that will hold the results
    // - If we're starting one of our dictionary keys, initialize `currentValue` (otherwise leave `nil`)
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == entityName {
            self.currentDictionary = [String: String]()
        } else if entityElements.contains(elementName) {
            self.currentValue = String()
        }
    }
    
    // found characters
    //
    // - If this is an element we care about, append those characters.
    // - If `currentValue` still `nil`, then do nothing.
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard !string.isEmpty else { return }
        self.currentValue? += string
    }
    
    // end element
    //
    // - If we're at the end of the whole dictionary, then save that dictionary in our array
    // - If we're at the end of an element that belongs in the dictionary, then save that value in the dictionary
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == self.entityName {
            self.results.append(self.currentDictionary)
            self.currentDictionary = nil
        } else if entityElements.contains(elementName) {
            self.currentDictionary[elementName] = currentValue
            self.currentValue = nil
        }
        
    }
    
    // Just in case, if there's an error, report it. (We don't want to fly blind here.)
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        self.currentValue = nil
        self.currentDictionary = nil
        self.results = []
    }
}
