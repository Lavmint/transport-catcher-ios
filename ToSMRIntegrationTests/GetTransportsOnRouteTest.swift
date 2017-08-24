//
//  GetTransportsOnRouteTest.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 24/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import XCTest
import ToSMR

class GetTransportsOnRouteTest: XCTestCase {
    
    func testMultipleRoutesSucceed() {
        
        XCTAssertNotNil(ServiceMock.shared)
        
        let expectedCase = expectation(description: "requestTransportOnMultipleRoutes")
        ServiceMock.shared?.transports(onRoutes: [13, 23, 434], limitation: 100) { (box) in
            
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
        
        let expectedCase = expectation(description: "requestTransportOnRoutesWithUnregisteredClient")
        service.transports(onRoutes: [13, 23, 434], limitation: 100) { (box) in
            
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
