//
//  BGSyntaxHighlighter - UIFont+BGSyntaxHighlighterTests.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import <GHUnitIOS/GHUnit.h>
#import "UIFont+BGSyntaxHighlighter.h"

@interface UIFont_BGSyntaxHighlighterTests : GHViewTestCase
{
    
}
@end

@implementation UIFont_BGSyntaxHighlighterTests

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
}

- (void)tearDown {
    // Run after each test method
}

- (void)testCourier {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    label.text = @"UIFont+BGSyntaxHighlighter\nBGSyntaxHighlighter+UIFont";
    label.numberOfLines = 2;
    label.font = [UIFont courierFontOfSize:12];
    GHVerifyView(label);
}

@end
