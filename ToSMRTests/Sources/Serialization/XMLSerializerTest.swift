//
//  XMLSerializerTest.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 25/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import XCTest
@testable import ToSMR

class XMLSerializerTest: XCTestCase {
    
    var serializator: Serializer!
    
    override func setUp() {
        super.setUp()
        serializator = XMLSerializer()
    }
    
    override func tearDown() {
        serializator = nil
        super.tearDown()
    }
    
    func testFullStopDBDeserialization() {
        
        guard let stops: [TransportStop] = serializator.object(from: DataStub.stopsFullDBXML) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(stops.count, 1419)
        
        guard let stop1185 = stops.filter({ $0.id == 1185 }).first else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(stop1185.id, 1185)
        XCTAssertEqual(stop1185.name, "Проходная ОАО \"Моторостроитель\"")
        XCTAssertEqual(stop1185.nameEn, "Prohodnaya OAO \"Motorostroitel'\"")
        XCTAssertEqual(stop1185.adjacentStreet, "на пр. Кирова")
        XCTAssertEqual(stop1185.adjacentStreetEn, "on Prospekt Kirova street")
        XCTAssertEqual(stop1185.direction, "в сторону пл. Кирова")
        XCTAssertEqual(stop1185.directionEn, "towards Ploshchad Kirova")
        XCTAssertEqual(stop1185.cluster, "")
        XCTAssertEqual(stop1185.busesMunicipal, "")
        XCTAssertEqual(stop1185.busesCommercial, "")
        XCTAssertEqual(stop1185.busesPrigorod, "")
        XCTAssertEqual(stop1185.busesSeason, "")
        XCTAssertEqual(stop1185.busesSpecial, "")
        XCTAssertEqual(stop1185.tramways, "8, 25")
        XCTAssertEqual(stop1185.trolleybuses, "")
        XCTAssertEqual(stop1185.metros, "")
        XCTAssertEqual(stop1185.hasTimeBoard, false)
        XCTAssertEqual(stop1185.latitude, 53.2023200177197)
        XCTAssertEqual(stop1185.longitude, 50.2831816867031)
        XCTAssertEqual(stop1185.angle, 124)
    }
}
