//
//  ViewController.h
//  College_Profile_Objc
//
//  Created by Dan Morton on 7/9/15.
//  Copyright (c) 2015 Dan Morton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollegeProfile-Swift.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *colleges;

@end


