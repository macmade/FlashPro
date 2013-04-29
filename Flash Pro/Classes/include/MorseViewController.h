/*******************************************************************************
 * Copyright (c) 2011, eosgarden
 * All rights reserved
 ******************************************************************************/
 
 /*!
  * @file   MorseViewController.h
  * @author Jean-David Gadina <macmade@eosgarden.com>
  */

/* $Id$ */

@class MorseTableDataSource;
@class MorseTableDelegate;
@class MorseEditViewController;

@interface MorseViewController: UIViewController
{
@protected
    
    UITableView             * table;
    MorseTableDataSource    * tableDataSource;
    MorseTableDelegate      * tableDelegate;
    UIBarButtonItem         * addButton;
    UIBarButtonItem         * editButton;
    
@private
    
    id r1;
    id r2;
}

@property( nonatomic, retain ) IBOutlet UITableView     * table;
@property( nonatomic, retain ) IBOutlet UIBarButtonItem * addButton;
@property( nonatomic, retain ) IBOutlet UIBarButtonItem * editButton;

- ( IBAction)add: ( id )sender;
- ( IBAction)edit: ( id )sender;
- ( IBAction)endEdit: ( id )sender;

@end
