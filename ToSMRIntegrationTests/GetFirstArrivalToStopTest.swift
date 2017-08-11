//
//  ToSMRIntegrationTests.swift
//  ToSMRIntegrationTests
//
//  Created by Alexey Averkin on 08/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import XCTest
import Foundation
import ToSMR

class GetFirstArrivalToStopTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        guard let infoDictionary = Bundle(for: GetFirstArrivalToStopTest.self).infoDictionary else {
            XCTFail("Client id not found in info plits")
            return
        }
        
        guard let clientId = infoDictionary["clientId"] as? String, let secret = infoDictionary["secret"] as? String else {
            XCTFail()
            return
        }
        
        ToSamaraService.configure(clientId: clientId, secret: secret)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConnection() {
        
        let expectedCase = expectation(description: "getFirstArrivalToStopTest succeed")
        
        var expectedBox: ToSamaraService.CompletionBox<[Arrival]>? = nil
        ToSamaraService.approximateArrivale(toStop: 9, limitation: 10) { (box) in
            expectedBox = box
            expectedCase.fulfill()
        }
        
        wait(for: [expectedCase], timeout: 20)
        XCTAssertEqual(expectedBox?.httpResponse?.statusCode, 200)
    }
    
}
