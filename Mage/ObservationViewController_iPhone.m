//
//  ObservationViewController_iPhone.m
//  MAGE
//
//

#import "ObservationViewController_iPhone.h"

@implementation ObservationViewController_iPhone

- (NSMutableArray *) getHeaderSection {
    NSMutableArray *headerSection = [[NSMutableArray alloc] initWithObjects:@"header", @"map", @"actions", nil];
    
    NSSet *favorites = [self.observation.favorites filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.favorite = %@", [NSNumber numberWithBool:YES]]];
    if ([favorites count]) {
        [headerSection insertObject:@"favorites" atIndex:2];
    };
    
    return headerSection;
}

- (NSMutableArray *) getAttachmentsSection {
    NSMutableArray *attachmentsSection = [[NSMutableArray alloc] init];
    
    if (self.observation.attachments.count != 0) {
        [attachmentsSection addObject:@"attachments"];
    }
    
    return attachmentsSection;
}

- (void) updateFavorites {
    NSSet *favorites = [self.observation.favorites filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.favorite = %@", [NSNumber numberWithBool:YES]]];

    NSMutableArray *headerSection = [self.tableLayout objectAtIndex:0];
    
    NSInteger favoritesCount = [favorites count];
    
    if ([headerSection containsObject:@"favorites"] && favoritesCount == 0) {
        [headerSection removeObjectAtIndex:2];
        [self.propertyTable beginUpdates];
        [self.propertyTable deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.propertyTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.propertyTable endUpdates];
    } else if (![headerSection containsObject:@"favorites"] && favoritesCount > 0) {
        [headerSection insertObject:@"favorites" atIndex:2];
        [self.propertyTable insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.propertyTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } else if ([headerSection containsObject:@"favorites"]) {
        [self.propertyTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0], [NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

@end
