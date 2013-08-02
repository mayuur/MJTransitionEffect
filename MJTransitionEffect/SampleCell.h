//
//  ClientCell.h
//  PersonalTraining
//
//
//

#import <UIKit/UIKit.h>

@class AsyncImageView;

@interface SampleCell : UITableViewCell {
    
}

@property (retain, nonatomic) IBOutlet UILabel *labelForPlace;
@property (retain, nonatomic) IBOutlet UILabel *labelForCountry;
@property (retain, nonatomic) IBOutlet UIImageView *imageview;

@end
