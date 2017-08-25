//
//  GetStopsFullDBTest.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 26/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import XCTest
import ToSMR

class GetStopsFullDBTest: XCTestCase {
    
    func testSucceed() {
        
        XCTAssertNotNil(ServiceMock.shared)
        
        let expectedCase = expectation(description: "requestFullStopsBD")
        ServiceMock.shared?.stops { (box) in
            
            switch box.result {
            case .succeed(let stops):
                XCTAssertNotNil(stops)
            case .error(let error):
                XCTFail(error.localizedDescription)
            }
            expectedCase.fulfill()
        }
        wait(for: [expectedCase], timeout: 10)
    }
}
