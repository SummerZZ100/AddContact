//
//  ContactTool.m
//  NewContacts
//
//  Created by ZhangXiaosong on 2018/11/21.
//  Copyright © 2018 ZhanXiaosong. All rights reserved.
//

#import "ContactTool.h"

@implementation ContactTool
    
#pragma mark - internal methdos -
    
    
    /**
     获取通讯录权限
     */
    - (BOOL)hasContactAuthorize:(CNContactStore *)contactStore
    {
        __block BOOL actualGranted = YES;
        
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted == YES){
                actualGranted = YES;
            }
            else{
                actualGranted = NO;
            }
        }];
        
        return actualGranted;
    }
    
/**
 创建客服信息
 */
- (CNMutableContact *)createServiceContact
    {
        CNMutableContact *contact = [[CNMutableContact alloc] init];
        contact.organizationName = @"XX客服";
        CNPhoneNumber *mobileNumber = [[CNPhoneNumber alloc] initWithStringValue:@"1582103830320"];
        CNLabeledValue *mobilePhone = [[CNLabeledValue alloc] initWithLabel:CNLabelPhoneNumberiPhone value:mobileNumber];
        contact.phoneNumbers = @[mobilePhone];
        return contact;
    }
    
    /**
     添加客服联系人
     */
    - (void)addServiceContact:(CNMutableContact *)contact
    {
        CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
        [saveRequest addContact:contact toContainerWithIdentifier:nil];
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore executeSaveRequest:saveRequest error:nil];
    }
    
    /**
     删除联系人
     */
    - (void)deleteContact:(CNMutableContact *)contact
    {
        CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
        [saveRequest deleteContact:contact];
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore executeSaveRequest:saveRequest error:nil];
    }
    
    /**
     判断是否存在指定的联系人
     */
    -(CNContact *)isExitContact:(NSString *)organizationName
    {
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        NSPredicate *predicate = [CNContact predicateForContactsMatchingName:organizationName];
        NSArray *keysToFetch = @[CNContactEmailAddressesKey,[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName]];
        NSArray *contact = [contactStore unifiedContactsMatchingPredicate:predicate keysToFetch:keysToFetch error:nil];
        return [contact firstObject];
    }
    
    /**
     更新联系人
     */
    - (void)updateContact:(CNMutableContact *)contact
    {
        CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
        [saveRequest updateContact:contact];
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        NSError *error = nil;
        BOOL saveStatus = [contactStore executeSaveRequest:saveRequest error:&error];
        if(saveStatus == NO){
            NSLog(@"error: %@",error);
        }
    }
    
    #pragma mark - outside methdos -
    
    /**
     更新手机联系人信息
     */
    - (void)updatePhoneContact
    {
        CNContact *contact = [self isExitContact:@"XX客服"];
        if(contact){
            CNMutableContact *contactOld = [contact mutableCopy];
            [self deleteContact:contactOld];
            CNMutableContact *contactNew = [self createServiceContact];
            [self addServiceContact:contactNew];
        }
        else{
            CNMutableContact *contact = [self createServiceContact];
            [self addServiceContact:contact];
        }
    }
    
    /**
     授权并创建手机联系人到通讯录
     */
    - (BOOL)createPhoneContact
    {
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        
        switch ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]) {
            case CNAuthorizationStatusNotDetermined:{
                BOOL granted = [self hasContactAuthorize:contactStore];
                if(granted){
                    [self updatePhoneContact];
                    return YES;
                }
                else{
                    return NO;
                }
            }
            case CNAuthorizationStatusAuthorized:
            {
                [self updatePhoneContact];
                return YES;
            }
            
            break;
            
            default:
            return NO;
            break;
        }
    }
    

@end
