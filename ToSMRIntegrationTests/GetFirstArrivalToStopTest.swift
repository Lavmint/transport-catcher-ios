//
//  ToSMRIntegrationTests.swift
//  ToSMRIntegrationTests
//
//  Created by Alexey Averkin on 08/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import XCTest

class GetFirstArrivalToStopTest: XCTestCase {

    func testConnection() {
        
        XCTAssertNotNil(ServiceMock.shared)
        
        let expectedCase = expectation(description: "getFirstArrivalToStopTest succeed")
        ServiceMock.shared?.approximateArrivale(toStop: 9, limitation: 10) { (box) in
            XCTAssertEqual(box.httpResponse?.statusCode, 200)
            expectedCase.fulfill()
        }
        wait(for: [expectedCase], timeout: 20)
    }
    
}
