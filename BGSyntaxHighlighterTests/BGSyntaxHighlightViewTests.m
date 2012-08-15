//
//  BGSyntaxHighlighter - BGSyntaxHighlightViewTests.m
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
//  Created by: KAZUMA Ukyo
//

#import <GHUnitIOS/GHUnit.h>
#import "BGSyntaxHighlightView.h"
#import "BGCodeObject.h"
#import "NSBundle+SyntaxHighlighter.h"

@interface BGSyntaxHighlightView()
@property(nonatomic, strong) UIScrollView *lineNumberScrollView;
@property(nonatomic, strong) UIScrollView *codeScrollView;
@property(nonatomic, strong) NSMutableArray *lineNumberViews;
@property(nonatomic, strong) NSMutableArray *lineViews;
@end

@interface BGSyntaxHighlightViewTests : GHViewTestCase
{
    BGSyntaxHighlightView *view;
    BGCodeObject *codeObject;
}
@end

@implementation BGSyntaxHighlightViewTests

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
    view = [[BGSyntaxHighlightView alloc] initWithFrame:CGRectZero];
    codeObject = [[BGCodeObject alloc] initWithCodeString:[NSBundle codeStringForResouce:@"mockObjective-C" ofType:@"txt"]];
    view.codeObject = codeObject;
}

- (void)tearDown {
    // Run after each test method
}

- (void)testNormalView
{
    view.frame = CGRectMake(0, 0, 320, 460);
    GHVerifyView(view);
}

- (void)testBufferingView
{
    view.frame = CGRectMake(0, 0, 320, 100);
    GHVerifyView(view);
    GHAssertEquals(8U, [view.lineNumberViews count], @"使い回す用のビューはceil(100*1.5 / 20)で8個");
    GHAssertEquals(8U, [view.lineViews count], @"使い回す用のビューは(100*1.5 / 20)で8個");
    [view.lineNumberScrollView scrollRectToVisible:CGRectMake(0, 180, 320, 180) animated:YES];
    GHVerifyView(view);
}

@end
