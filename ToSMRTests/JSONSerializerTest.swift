//
//  JSONSerializerTest.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import XCTest
@testable import ToSMR

class JSONSerializerTest: XCTestCase {
    
    var serializator: Serializer!
    
    override func setUp() {
        super.setUp()
        serializator = JSONSerializer()
    }
    
    override func tearDown() {
        serializator = nil
        super.tearDown()
    }
    
    func testGetFirstArrivalToStopDeserialization() {
        
        guard let arrivals: [Arrival] = serializator.object(from: DataStub.getFirstArrivalToStop) else {
            XCTFail()
            return
        }
        
        guard arrivals.count == 10 else {
            XCTFail()
            return
        }
        
        let arrivalHullNumber930573 = arrivals[3]
        XCTAssertEqual(arrivalHullNumber930573.number, "37")
        XCTAssertEqual(arrivalHullNumber930573.route, 38)
        XCTAssertEqual(arrivalHullNumber930573.model, nil)
        XCTAssertEqual(arrivalHullNumber930573.hullNumber, 930573)
        XCTAssertEqual(arrivalHullNumber930573.nextStopId, 573)
        XCTAssertEqual(arrivalHullNumber930573.timeInSeconds, 819.61)
        XCTAssertEqual(arrivalHullNumber930573.stateNumber, "ЕК132 63")
        XCTAssertEqual(arrivalHullNumber930573.isInvalidFriendly, false)
        XCTAssertEqual(arrivalHullNumber930573.nextStopName, "Парк им. Гагарина")
        XCTAssertEqual(arrivalHullNumber930573.requestedStopId, 9)
        XCTAssertEqual(arrivalHullNumber930573.time, 13)
        XCTAssertEqual(arrivalHullNumber930573.type, .bus)
        XCTAssertEqual(arrivalHullNumber930573.spanLength, 645.6)
        XCTAssertEqual(arrivalHullNumber930573.remainingLength, 633.0)
    }
    
    func testGetRouteArrivalToStopDeserialization() {
        
        guard let arrivals: [Arrival] = serializator.object(from: DataStub.getRouteArrivalToStop) else {
            XCTFail()
            return
        }
        
        guard arrivals.count == 4 else {
            XCTFail()
            return
        }
        
        let arrivalHullNumber950170 = arrivals[2]
        XCTAssertEqual(arrivalHullNumber950170.number, "247")
        XCTAssertEqual(arrivalHullNumber950170.route, 193)
        XCTAssertEqual(arrivalHullNumber950170.model, "HYUNDAI County")
        XCTAssertEqual(arrivalHullNumber950170.hullNumber, 950170)
        XCTAssertEqual(arrivalHullNumber950170.nextStopId, 36)
        XCTAssertEqual(arrivalHullNumber950170.timeInSeconds, 2166.99)
        XCTAssertEqual(arrivalHullNumber950170.stateNumber, "С759АС 163")
        XCTAssertEqual(arrivalHullNumber950170.isInvalidFriendly, false)
        XCTAssertEqual(arrivalHullNumber950170.nextStopName, "Площадь им. Кирова")
        XCTAssertEqual(arrivalHullNumber950170.requestedStopId, 9)
        XCTAssertEqual(arrivalHullNumber950170.time, 36)
        XCTAssertEqual(arrivalHullNumber950170.type, .bus)
        XCTAssertEqual(arrivalHullNumber950170.spanLength, 245.6)
        XCTAssertEqual(arrivalHullNumber950170.remainingLength, 36.0)
    }
    
    func testGetTransportsOnRouteDeserialization() {
        
        guard let transports: [Transport] = serializator.object(from: DataStub.getTransportsOnRoute) else {
            XCTFail()
            return
        }
        
        guard transports.count == 1 else {
            XCTFail()
            return
        }
        
        let transportHullNumber947772 = transports[0]
        XCTAssertEqual(transportHullNumber947772.direction, 316.1384462)
        XCTAssertEqual(transportHullNumber947772.number, "21")
        XCTAssertEqual(transportHullNumber947772.route, 13)
        XCTAssertEqual(transportHullNumber947772.model, "ЛИАЗ 529370")
        XCTAssertEqual(transportHullNumber947772.hullNumber, 947772)
        XCTAssertEqual(transportHullNumber947772.nextStopId, 381)
        XCTAssertEqual(transportHullNumber947772.stateNumber, "У617ТР 163")
        XCTAssertEqual(transportHullNumber947772.isInvalidFriendly, true)
        XCTAssertEqual(transportHullNumber947772.longitude, 50.23153755394451)
        XCTAssertEqual(transportHullNumber947772.latitude, 53.25505451580764)
        XCTAssertEqual(transportHullNumber947772.type, .bus)
    }
    
    func testGetSurroundingTransportsDeserialization() {
        
        guard let transports: [Transport] = serializator.object(from: DataStub.getSurroundingTransports) else {
            XCTFail()
            return
        }
        
        guard transports.count == 12 else {
            XCTFail()
            return
        }
        
        let transoprtHullNumber947207 = transports[7]
        XCTAssertEqual(transoprtHullNumber947207.direction, 261.228771227)
        XCTAssertEqual(transoprtHullNumber947207.number, "61")
        XCTAssertEqual(transoprtHullNumber947207.route, 68)
        XCTAssertEqual(transoprtHullNumber947207.model, "")
        XCTAssertEqual(transoprtHullNumber947207.hullNumber, 947207)
        XCTAssertEqual(transoprtHullNumber947207.nextStopId, 817)
        XCTAssertEqual(transoprtHullNumber947207.stateNumber, "Х836КХ 163")
        XCTAssertEqual(transoprtHullNumber947207.isInvalidFriendly, false)
        XCTAssertEqual(transoprtHullNumber947207.longitude, 50.08759431918272)
        XCTAssertEqual(transoprtHullNumber947207.latitude, 53.18614069506027)
        XCTAssertEqual(transoprtHullNumber947207.type, .bus)
    }
}
