//
//  ViewController.m
//  AnimationMaximize
//
//  Created by mayur on 7/31/13.
//  Copyright (c) 2013 mayur. All rights reserved.
//

#import "ViewController.h"
#import "SampleCell.h"
#import "DetailViewController.h"

#define TABLE_HEIGHT 80

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray* arrayForPlaces;

@end

@implementation ViewController

- (void)dealloc
{
    [_arrayForPlaces release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"SampleData" ofType:@"plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];    
    self.arrayForPlaces = [plistDict objectForKey:@"Data"];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayForPlaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SampleCell *cell = (SampleCell*) [tableView dequeueReusableCellWithIdentifier:@"SampleCell"];
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SampleCell" owner:[SampleCell class] options:nil];
        cell = (SampleCell *)[nib objectAtIndex:0];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    NSDictionary* dict = [self.arrayForPlaces objectAtIndex:indexPath.row];
    
    cell.labelForPlace.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Place"]];
    cell.labelForCountry.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Country"]];
    cell.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Image"]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect cellFrameInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect cellFrameInSuperview = [tableView convertRect:cellFrameInTableView toView:[tableView superview]];
    
    DetailViewController* detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    NSMutableDictionary* dict = [self.arrayForPlaces objectAtIndex:indexPath.row];
    detailViewController.dictForData = dict;
    detailViewController.yOrigin = cellFrameInSuperview.origin.y;
    [self.navigationController pushViewController:detailViewController animated:NO];
    [detailViewController release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
