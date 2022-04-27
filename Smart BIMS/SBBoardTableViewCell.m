//
//  SBBoardTableViewCell.m
//  SmartBIMS
//
//  Created by Jennis on 2014. 4. 11..
//
//

#import "SBBoardTableViewCell.h"

@implementation SBBoardTableViewCell

@synthesize m_boardTitleLabel;
@synthesize m_endDateLabel;
@synthesize m_enterDateLabel;
@synthesize m_enterNameLabel;
@synthesize m_enterTimeLabel;
@synthesize m_startDateLabel;

@synthesize m_target;
@synthesize m_selector;

@synthesize m_seqno;
@synthesize m_indexId;

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
//    SBBoardTableViewCell *cell;
//    UIViewController *controller = [[UIViewController alloc] initWithNibName:@"SBBoardTableViewCell" bundle:nil];
//    cell = (SBBoardTableViewCell *)controller.view;
//    [controller release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
}

- (void) setDelegate:(id)target selector:(SEL)selector
{
	self.m_target = target;
	self.m_selector = selector;
}

- (IBAction)onToBoardContentView:(id)sender
{
    NSDictionary* bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.m_seqno, @"seqno",
                                self.m_indexId, @"indexId",
                                nil];
    
    [m_target performSelector:m_selector withObject:bodyObject];
}

@end
