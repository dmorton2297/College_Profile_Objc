//
//  ViewController.m
//  College_Profile_Objc
//
//  Created by Dan Morton on 7/9/15.
//  Copyright (c) 2015 Dan Morton. All rights reserved.
//

#import "ViewController.h"
#import "CollegeProfile-Swift.h"
#import "DetailViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation ViewController

@synthesize colleges;

- (void)viewDidLoad {
    [super viewDidLoad];
    College *collegeOne = [[College alloc]initWithCollegeWithName:@"Purdue" collegeWithPopulation:40000 collegeWithImage:[UIImage imageNamed:@"default.png"]];
    College *collegeTwo = [[College alloc]initWithCollegeWithName:@"U of W Madison" collegeWithPopulation:30000 collegeWithImage:[UIImage imageNamed:@"default.png"]];
    colleges = [[NSMutableArray alloc]init];
    [colleges addObject:collegeOne];
    [colleges addObject:collegeTwo];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [self.myTableView reloadData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return colleges.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    College *college = colleges[indexPath.row];
    NSString *name = college.name;
    
    
    cell.textLabel.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"segue" sender:self];
}

- (IBAction)addCollegeButtonTapped:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add College" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Put college name here";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Put population of college here";
    }];
    
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *nameField = alert.textFields[0];
        UITextField *populationTextField = alert.textFields[1];
        if (populationTextField.text != nil && nameField.text != nil){
            int population = (int)populationTextField.text.integerValue;
            if (population) {
                College *newCollege = [[College alloc]initWithCollegeWithName:nameField.text collegeWithPopulation:30000 collegeWithImage:[UIImage imageNamed:@"Default.png"]];
                [self appendToCollegeArray:newCollege];
                [self.myTableView reloadData];
            }
        }
        
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    [alert addAction:addAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:true completion:nil];
    
}  

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController *dvc = (DetailViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = self.myTableView.indexPathForSelectedRow;
    College *newCollege = colleges[indexPath.row];
    dvc.college = newCollege;
    [self.myTableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void) appendToCollegeArray: (College*)college {
    [colleges addObject:college];
    
    
}
@end
