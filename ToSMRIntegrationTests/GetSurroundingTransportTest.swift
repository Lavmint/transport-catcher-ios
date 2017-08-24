//
//  GetSurroundingTransportTest.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 24/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import XCTest
import ToSMR

class GetSurroundingTransportTest: XCTestCase {
    
    func testSucceed() {
        
        XCTAssertNotNil(ServiceMock.shared)
        
        let expectedCase = expectation(description: "requestSurroundingTransportSucceed")
        ServiceMock.shared?.transports(inRadius: 1000, atLongitude: 50.1, atLatitude: 53.1, limitation: 100) { (box) in
            
            switch box.result {
            case .succeed(let transports):
                XCTAssertNotNil(transports)
            case .error(let error):
                XCTFail(error.localizedDescription)
            }
            expectedCase.fulfill()
        }
        wait(for: [expectedCase], timeout: 10)
    }
    
    func testFailedWithUnregisteredClient() {
        
        let service = Service(clientId: "peace", secret: "doorball")
        
        let expectedCase = expectation(description: "requestSurroundingTransportWithUnregisteredClient")
        service.transports(inRadius: 1000, atLongitude: 50.1, atLatitude: 53.1, limitation: 100) { (box) in
            
            switch box.result {
            case .succeed(_):
                XCTFail()
            default:
                break
            }
            expectedCase.fulfill()
        }
        wait(for: [expectedCase], timeout: 10)
    }
}
