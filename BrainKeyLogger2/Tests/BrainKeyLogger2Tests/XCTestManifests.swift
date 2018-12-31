import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BrainKeyLogger2Tests.allTests),
    ]
}
#endif