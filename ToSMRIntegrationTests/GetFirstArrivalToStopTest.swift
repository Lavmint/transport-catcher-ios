//
//  ToSMRIntegrationTests.swift
//  ToSMRIntegrationTests
//
//  Created by Alexey Averkin on 08/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import XCTest
import ToSMR

class GetFirstArrivalToStopTest: XCTestCase {

    func testSucceedWithStopAndCount() {
        
        XCTAssertNotNil(ServiceMock.shared)
        
        let expectedCase = expectation(description: "requestArrivalsWithStopAndCount")
        ServiceMock.shared?.approximateArrivale(toStop: 9, limitation: 10) { (box) in

            switch box.result {
            case .error(let error):
                XCTFail(error.localizedDescription)
            default:
                break
            }
            expectedCase.fulfill()
        }
        wait(for: [expectedCase], timeout: 10)
    }
    
    func testSucceedWithStopOnly() {
        
        XCTAssertNotNil(ServiceMock.shared)
        
        let expectedCase = expectation(description: "requestArrivalsWithStopOnly")
        ServiceMock.shared?.approximateArrivale(toStop: 9) { (box) in
            
            switch box.result {
            case .error(let error):
                XCTFail(error.localizedDescription)
            default:
                break
            }
            expectedCase.fulfill()
        }
        wait(for: [expectedCase], timeout: 10)
    }
    
    func testFailedWithUnregisteredClient() {
        
        let service = Service(clientId: "peace", secret: "doorball", serializer: JSONSerializer())
        
        let expectedCase = expectation(description: "requestArrivalsWithStopOnly")
        service.approximateArrivale(toStop: 9) { (box) in
            
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
