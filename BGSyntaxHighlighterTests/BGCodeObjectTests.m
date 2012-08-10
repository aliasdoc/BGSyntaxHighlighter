//
//  BGSyntaxHighlighter - BGCodeObjectTests.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import <GHUnitIOS/GHUnit.h>
#import "BGCodeObject.h"
#import "NSBundle+SyntaxHighlighter.h"

@interface BGCodeObjectTests : GHTestCase
{
    BGCodeObject *codeObject
}
@end

@implementation BGCodeObjectTests

- (BOOL)shouldRunOnMainThread {
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES
    return NO;
}

- (void)setUpClass {
    // Run at start of all tests in the class
}

- (void)tearDownClass {
    // Run at end of all tests in the class
}

- (void)setUp {
    // Run before each test method
    codeObject = [[BGCodeObject alloc] initWithCodeString:[NSBundle codeStringForResouce:@"mockObjective-C" ofType:@"txt"]];
}

- (void)tearDown {
    // Run after each test method
    [codeObject release];
}

#pragma mark - interfaces
- (void)testNumberOfLines {
    GHAssertEquals(14, [codeObject numberOfCodeLines], @"14行あるはずだが");
}

- (void)testCodeStringForLineAtIndex {
    GHAssertEquals(@"//",[codeObject codeStringForLineAtIndex:0], @"1行目はコメントだけ");
    GHAssertEquals(@"//  mockObjective-C.h",[codeObject codeStringForLineAtIndex:1], @"2行目はファイル名");

}


@end
