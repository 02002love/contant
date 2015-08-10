//
//  MainTableViewController.m
//  私人通讯录
//
//  Created by JinWei on 15/8/4.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "MainTableViewController.h"
#import "AddViewController.h"
#import "EditViewController.h"
#import "ContantCell.h"
#import "FMDatabase.h"

@interface MainTableViewController ()<UIActionSheetDelegate,AddViewControllerDelegate,EditViewControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)FMDatabase * fm;
@property (nonatomic,strong)NSIndexPath * path;

- (IBAction)logout:(id)sender;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle =0;
    
    self.fm = [[FMDatabase alloc]initWithPath:[NSString stringWithFormat:@"%@/Documents/data.db",NSHomeDirectory()]];
    NSLog(@"======%@",[NSString stringWithFormat:@"%@/Documents/data.db",NSHomeDirectory()]);
    if ([self.fm open]) {
        
        //        BOOL isSucceed = [self.fm executeUpdate:@"CREATE TABLE contant(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)"];
        BOOL isSucceed = [self.fm executeUpdate:@"CREATE TABLE contant(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT)"];
        if (isSucceed) {
            NSLog(@"创建表成功");
        }else{
            
            NSLog(@"创建表失败");
        }
    }
    [self loadData];
    
}
-(void)loadData{
    _dataArray = [NSMutableArray array];
    FMResultSet * result = [self.fm executeQuery:@"select * from contant"];
    while (result.next) {
        
        ContantModel * model = [[ContantModel alloc]init];
        model.name = [result stringForColumn:@"name"];
        model.phoneNum =[result stringForColumn:@"phone"];
        [_dataArray addObject:model];
    }
    [self.tableView reloadData];
    
    
}
//延迟加载
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContantCell *cell = [ContantCell cellWithTableView:tableView];
    
    cell.model = self.dataArray[indexPath.row];
    //    UITableViewCellAccessoryDisclosureIndicator,    箭头
    //    UITableViewCellAccessoryDetailDisclosureButton, 详情图标
    //    UITableViewCellAccessoryCheckmark,              对号
    //    UITableViewCellAccessoryDetailButton            详情图标
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"是否要删除?" message:nil delegate: self cancelButtonTitle:@"取消" otherButtonTitles: @"确认", nil];
    [alert show];
    
    if (editingStyle==1) {
        
//        ContantModel * model = self.dataArray[indexPath.row];
//        [self.dataArray removeObjectAtIndex:indexPath.row];
//        NSString * query = [NSString stringWithFormat:@"DELETE FROM contant WHERE phone = %@",model.phoneNum];
//        NSLog(@"SQL:%@",query);
//        BOOL isSucceed = [self.fm executeUpdate:query];
//        if (isSucceed) {
//            NSLog(@"删除成功");
//        }else{
//            
//            NSLog(@"删除失败");
//        }
        self.path =indexPath;
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath]  withRowAnimation:UITableViewRowAnimationLeft];
        
    }
    
    
}

#pragma mark  ==alertView 代理==


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex ==0) {
        NSLog(@"%ld",(long)buttonIndex);
        return;
    }else{
        NSLog(@"%ld",(long)buttonIndex);
        ContantModel * model = self.dataArray[self.path.row];
        [self.dataArray removeObjectAtIndex:self.path.row];
        NSString * query = [NSString stringWithFormat:@"DELETE FROM contant WHERE phone = %@",model.phoneNum];
        NSLog(@"SQL:%@",query);
        BOOL isSucceed = [self.fm executeUpdate:query];
        if (isSucceed) {
            NSLog(@"删除成功");
        }else{
            
            NSLog(@"删除失败");
        }
        

         [self.tableView deleteRowsAtIndexPaths:@[self.path]  withRowAnimation:UITableViewRowAnimationLeft];
        
    }
    
    
}


/*
 
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)logout:(id)sender {
    
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"是否确定注销?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles: nil, nil];
    
    [sheet showInView:self.view];
    
    
}


#pragma mark  ==UIActionSheet代理==


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex != 0) return;
    
    [self.navigationController popViewControllerAnimated:YES];;
    
    
}

#pragma mark  ==添加代理实现==
-(void)addViewController:(AddViewController *)vc didAddContactWithContantModel:(ContantModel *)contant{
    NSLog(@"%@",contant);
    
    [self.dataArray addObject:contant];
    BOOL isSucceed = [self.fm executeUpdate:@"insert into contant (name,phone) values (?,?)",contant.name,contant.phoneNum];
    if (isSucceed) {
        NSLog(@"写入成功");
    }else{
        
        NSLog(@"写入失败");
    }
    
    [self.tableView reloadData];
    
    
}
#pragma mark  ==编辑代理实现==
-(void)editViewController:(EditViewController *)edit saveContentsWithContant:(ContantModel *)contant{
    
    [self.tableView reloadData];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[AddViewController class]]) {
        AddViewController * vc = segue.destinationViewController;
        vc.delegate =self;
    }else if ([segue.destinationViewController isKindOfClass:[EditViewController class]]){
        
        EditViewController * vc = segue.destinationViewController;
        vc.model =self.dataArray[[self.tableView indexPathForSelectedRow].row];
        vc.delegate = self;
    }
    
}









@end
