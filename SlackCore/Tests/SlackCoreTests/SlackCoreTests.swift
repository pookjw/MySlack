//
//  SlackCoreTests.swift
//  
//
//  Created by Jinwoo Kim on 3/19/24.
//

import XCTest
@_spi(ForToolsIntegrationOnly) import Testing
@testable import SlackCore

final class SlackCoreTests: XCTestCase {
    func testAll() async {
        let eventRecorder = Event.ConsoleOutputRecorder(options: []) { string in
            print(string)
        }
        
        var configuration: Testing.Configuration = .init()
        
        configuration.testFilter = Testing.Configuration.TestFilter(includingAnyOf: [.init(kind: .stringLiteral("testGetUserProfileDictionary"))])
        
        configuration.isParallelizationEnabled = false
        configuration.eventHandler = { event, context in
            eventRecorder.record(event, in: context)
            
            guard case let .issueRecorded(issue) = event.kind else {
                return
            }
            if !issue.isKnown {
                self.record(
                    XCTIssue(
                        type: .assertionFailure,
                        compactDescription: String(describing: issue),
                        sourceCodeContext: .init(issue.sourceContext)
                    )
                )
            }
        }
        
        let runner: Testing.Runner = await .init(configuration: configuration)
        await runner.run()
    }
}

extension XCTSourceCodeContext {
  fileprivate convenience init(_ sourceContext: SourceContext) {
    let addresses = sourceContext.backtrace?.addresses.map { $0 as NSNumber } ?? []
    let sourceLocation = sourceContext.sourceLocation.map { sourceLocation in
      XCTSourceCodeLocation(
        filePath: sourceLocation._filePath,
        lineNumber: sourceLocation.line
      )
    }
    self.init(callStackAddresses: addresses, location: sourceLocation)
  }
}
