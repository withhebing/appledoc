//
//  GBCommentsProcessor-UnorderedListsTesting.m
//  appledoc
//
//  Created by Tomaz Kragelj on 30.8.10.
//  Copyright (C) 2010 Gentle Bytes. All rights reserved.
//

#import "GBComment.h"
#import "GBCommentsProcessor.h"

@interface GBCommentsProcessorUnorderedListsTesting : GBObjectsAssertor
@end

#pragma mark -

@implementation GBCommentsProcessorUnorderedListsTesting

- (void)testProcessCommentWithStore_unorderedLists_shouldAttachListToPreviousParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"Paragraph\n\n- Item"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	GBCommentParagraph *paragraph = [[comment paragraphs] objectAtIndex:0];
	[self assertParagraph:paragraph containsItems:[GBParagraphTextItem class], @"Paragraph", [GBParagraphListItem class], [NSNull null], nil];
	[self assertList:[paragraph.items objectAtIndex:1] isOrdered:NO containsParagraphs:@"Item", nil];
}

- (void)testProcessCommentWithStore_unorderedLists_shouldDetectMultipleLinesLists {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"Paragraph\n\n-Item1\n-Item2"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([[comment paragraphs] count], equalToInteger(1));
	GBCommentParagraph *paragraph = [comment.paragraphs objectAtIndex:0];
	[self assertParagraph:paragraph containsItems:[GBParagraphTextItem class], @"Paragraph", [GBParagraphListItem class], [NSNull null], nil];
	[self assertList:[paragraph.items objectAtIndex:1] isOrdered:NO containsParagraphs:@"Item1", @"Item2", nil];
}

//- (void)testProcessCommentWithStore_unorderedLists_shouldDetectItemsSpanningMutlipleLines {
//	// setup
//	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
//	GBComment *comment = [GBComment commentWithStringValue:@"Paragraph\n- Item1\nContinued\n-Item2"];
//	// execute
//	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
//	// verify
//	assertThatInteger([[comment paragraphs] count], equalToInteger(1));
//	assertThat([comment.firstParagraph stringValue], is(@"Paragraph\n- Item1\n- Item2"));
//}
//
//- (void)testProcessCommentWithStore_ul_shouldCreateParagraph {
//	// setup
//	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
//	GBComment *comment = [GBComment commentWithStringValue:@"- Item"];
//	// execute
//	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
//	// verify
//	assertThatInteger([[comment paragraphs] count], equalToInteger(1));
//	assertThat([comment.firstParagraph stringValue], is(@"- Item"));
//}
//
//#pragma mark Complex processing tests
//
//- (void)testProcessCommentWithStore_shouldProcessAllItems {
//	// setup
//	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
//	GBComment *comment = [GBComment commentWithStringValue:[GBRealLifeDataProvider fullMethodComment]];
//	// execute
//	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
//	// verify
//	assertThatInteger([comment.paragraphs count], equalToInteger(3));
//	assertThat([[comment.paragraphs objectAtIndex:0] stringValue], is(@"Short description."));
//	assertThat([[comment.paragraphs objectAtIndex:1] stringValue], is(@"Second paragraph with lot's of text split into two lines."));
//	assertThat([[comment.paragraphs objectAtIndex:2] stringValue], is(@"Third paragraph."));
//}
//
@end
