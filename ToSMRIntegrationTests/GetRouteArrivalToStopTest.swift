//
//  GetRouteArrivalToStopTest.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 23/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import XCTest
import ToSMR

class GetRouteArrivalToStopTest: XCTestCase {
    
    func testSucceedWithRouteAndStop() {
        
        XCTAssertNotNil(ServiceMock.shared)
        
        let expectedCase = expectation(description: "requestArrivalsWithRouteAndStop")
        ServiceMock.shared?.approximateArrivale(ofRoute: 193, toStop: 9) { (box) in
            
            switch box.result {
            case .succeed(let arrivals):
                XCTAssertNotNil(arrivals)
            case .error(let error):
                XCTFail(error.localizedDescription)
            }
            expectedCase.fulfill()
        }
        wait(for: [expectedCase], timeout: 10)
    }
    
    func testFailedWithUnregisteredClient() {
        
        let service = Service(clientId: "peace", secret: "doorball")
        
        let expectedCase = expectation(description: "requestArrivalsWithUnregisteredClient")
        service.approximateArrivale(ofRoute: 193, toStop: 9) { (box) in
            
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
