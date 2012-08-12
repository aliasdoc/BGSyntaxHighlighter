//
//  BGSyntaxHighlighter - BGSyntaxHighlightLineNumberViewTest.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import <GHUnitIOS/GHUnit.h>
#import "BGSyntaxHighlightLineNumberView.h"

@interface BGSyntaxHighlightLineNumberViewTest : GHViewTestCase
{
    BGSyntaxHighlightLineNumberView *view;
}
@end

@implementation BGSyntaxHighlightLineNumberViewTest

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
    view = [[BGSyntaxHighlightLineNumberView alloc] initWithFrame:CGRectMake(0, 0, 52, 20)];
    
}

- (void)tearDown {
    // Run after each test method
}

- (void)testAfterInitialized {
    GHVerifyView(view);
}

- (void)testSettedLineNumber {
    view.lineNumber = 1000;
    GHVerifyView(view);
}

@end
