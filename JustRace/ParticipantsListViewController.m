//
//  ParticipantsListViewController.m
//  JustRace
//
//  Created by Laborator iOS on 4/29/13.
//  Copyright (c) 2013 Andra Mititelu. All rights reserved.
//

#import "ParticipantsListViewController.h"
#import <Parse/Parse.h>

@interface ParticipantsListViewController ()

@end

@implementation ParticipantsListViewController

@synthesize race;

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

    
    PFQuery *query = [PFQuery queryWithClassName:@"Participation"];
    [query whereKey:@"raceName" equalTo:[race objectForKey:@"raceName"]];
    
    
        
    [query findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
        if (!error){
            participantsList = data;
            NSLog(@"nr participanti = %d", participantsList.count);
            [tableView reloadData];
        }else{
            NSLog(@"eroare");
        }
    }];
    
    PFQuery *secondQuery = [PFQuery queryWithClassName:@"User"];
    [secondQuery whereKey:@"username" matchesKey:@"username" inQuery:query];
    
    __block NSArray *usernames;
    [secondQuery findObjectsInBackgroundWithBlock:^(NSArray *data, NSError *error){
        if (!error){
            usernames = data;
            NSLog(@"nr participanti cu numele ala= %d", usernames.count);
            NSLog(@"primul username=%@", (NSString*)[[participantsList objectAtIndex:0]objectForKey:@"username"]);
            [tableView reloadData];
        }else{
            NSLog(@"eroare");
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
    return [participantsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"participant";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    PFObject *participant = (PFObject*)[participantsList objectAtIndex:indexPath.row];
        
    cell.textLabel.text = [participant objectForKey:@"username"];
       
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

@end