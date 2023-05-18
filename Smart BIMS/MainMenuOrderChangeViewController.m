//
//  MainMenuOrderChangeViewController.m
//  SmartBIMS
//
//  Created by hmwoo on 2023/03/28.
//

#import "MainMenuOrderChangeViewController.h"
#import "MenuOrderTableViewCell.h"
@interface MainMenuOrderChangeViewController ()

@end

@implementation MainMenuOrderChangeViewController
@synthesize menuListTableView;
@synthesize contentArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [menuListTableView setEditing:YES animated:YES];


    // 메뉴 객체 값 구성.
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"main_menu" ofType:@"plist"];
    contentArray = [NSMutableArray arrayWithContentsOfFile:sourcePath];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [menuListTableView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSUInteger row = [indexPath row];

}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [contentArray count];
    return 3;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* cellid = @"cellId";
    MenuOrderTableViewCell * cell = (MenuOrderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];

    if(cell == nil){

        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MenuOrderTableViewCell"
                                                     owner:self
                                                   options:nil];
        for(id oneObject in nib){
            if([oneObject isKindOfClass:[MenuOrderTableViewCell class]]){
                cell = (MenuOrderTableViewCell*)oneObject;
            }
        }
        
    }

    
//    cell.test.text = @"22";
//    cell.test.text = [[contentArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    return cell;
}

- (BOOL) tableView:(UITableView *)tableViewe canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    // 테이블 뷰 순서 변경 후 객체에 담아 저장 후 확인 버튼 클릭 시, API 통신 필요!

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}




@end
