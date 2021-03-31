//
//  TK_Font_TableViewController.m
//  dailyCode
//
//  Created by hello on 2021/3/31.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TK_Font_TableViewController.h"

@interface TK_Font_TableViewController ()
@property (strong, nonatomic) NSMutableArray *fontFamily;
@end

@implementation TK_Font_TableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    // 字体
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];

    self.fontFamily = [NSMutableArray arrayWithCapacity:[[UIFont familyNames] count]];
    
    for (id familyName in familyNames) {
        NSLog(@"family: %@", familyName);
        NSMutableDictionary *family = [NSMutableDictionary dictionaryWithCapacity:2];
        [family setObject:familyName forKey:@"name"];
        NSArray *fontNames = [NSArray arrayWithArray:[UIFont fontNamesForFamilyName:familyName]];
        NSMutableArray *fonts = [NSMutableArray arrayWithCapacity:[fontNames count]];
        for (id fontName in fontNames) {
            NSLog(@"name: %@", fontName);
            NSDictionary *font = [NSDictionary dictionaryWithObjectsAndKeys:fontName, @"name", [UIFont fontWithName:fontName size:14.0], @"font", nil];
            [fonts addObject:font];
        }
        
        [family setObject:fonts forKey:@"fonts"];
        
        [self.fontFamily addObject:family];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fontFamily.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id fontDict = [self.fontFamily objectAtIndex:section];
    id font = [fontDict objectForKey:@"fonts"];
    return [font count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    
    
    id fontDict = [self.fontFamily objectAtIndex:indexPath.section];
    id fonts = [fontDict objectForKey:@"fonts"];
    id font = [fonts objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ 这是中文字体！English.", [font objectForKey:@"name"]];
    cell.textLabel.font = [font objectForKey:@"font"];
    
    return cell;
}


@end
