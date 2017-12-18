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
        ServiceMock.shared?.approximateArrivals(ofRoute: 193, toStop: 9) { (box) in
            
            switch box.result {
            case .success(let arrivals):
                XCTAssertNotNil(arrivals)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectedCase.fulfill()
        }
        wait(for: [expectedCase], timeout: 10)
    }
    
    func testFailedWithUnregisteredClient() {
        
        let service = Service(clientId: "peace", secret: "doorball")
        
        let expectedCase = expectation(description: "requestArrivalsWithUnregisteredClient")
        service.approximateArrivals(ofRoute: 193, toStop: 9) { (box) in
            
            switch box.result {
            case .success(_):
                XCTFail()
            default:
                break
            }
            expectedCase.fulfill()
        }
        wait(for: [expectedCase], timeout: 10)
    }
}
