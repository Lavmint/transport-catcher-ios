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
        
        XCTAssertEqual(arrivals[3].transport.number, "37")
        XCTAssertEqual(arrivals[3].transport.route, 38)
        XCTAssertEqual(arrivals[3].transport.model, nil)
        XCTAssertEqual(arrivals[3].transport.hullNumber, 930573)
        XCTAssertEqual(arrivals[3].nextStopId, 573)
        XCTAssertEqual(arrivals[3].timeInSeconds, 819.61)
        XCTAssertEqual(arrivals[3].transport.stateNumber, "ЕК132 63")
        XCTAssertEqual(arrivals[3].transport.isInvalidFriendly, false)
        XCTAssertEqual(arrivals[3].nextStopName, "Парк им. Гагарина")
        XCTAssertEqual(arrivals[3].requestedStopId, 9)
        XCTAssertEqual(arrivals[3].time, 13)
        XCTAssertEqual(arrivals[3].transport.type, .bus)
        XCTAssertEqual(arrivals[3].spanLength, 645.6)
        XCTAssertEqual(arrivals[3].remainingLength, 633.0)
        
        

    }
}
