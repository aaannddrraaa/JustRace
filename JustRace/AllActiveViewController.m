//
//  AllActiveViewController.m
//  JustRace
//
//  Created by Laborator iOS on 4/3/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "AllActiveViewController.h"
#import "ActiveRaceViewController.h"
#import <Parse/Parse.h>

@interface AllActiveViewController ()

@end

@implementation AllActiveViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __block UITableView *tableView = self.tableView;
    
    //active = curse la care va participa, nu neaparat organizate de el
    PFQuery *partQuery = [PFQuery queryWithClassName:@"Participation"];
    [partQuery whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    
    PFQuery *raceQuery = [PFQuery queryWithClassName:@"Race"];
    [raceQuery whereKey:@"raceDate" greaterThan:[NSDate date]];
    [raceQuery whereKey:@"raceName" matchesKey:@"raceName" inQuery:partQuery];
    
    [raceQuery findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
        if (!error){
            NSLog(@"nr curse = %d", data.count);
            activeRaces = data;
            [tableView reloadData];
        } else{
            NSLog(@"eroare = %@",error);
        }
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [activeRaces count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"activeRace";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    PFObject *race = (PFObject *)[activeRaces objectAtIndex:indexPath.row];
    NSString *raceName = [race objectForKey:@"raceName"];
    
    cell.textLabel.text =  raceName;

    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSDictionary *race = [activeRaces objectAtIndex:path.row];
    [segue.destinationViewController setRace:race];
}

@end
