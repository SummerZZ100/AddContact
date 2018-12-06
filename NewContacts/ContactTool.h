//
//  ContactTool.h
//  NewContacts
//  手机通讯录工具类
//  Created by ZhangXiaosong on 2018/11/21.
//  Copyright © 2018 ZhanXiaosong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ContactsUI/ContactsUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactTool : NSObject
    
    
    /**
     更新手机联系人信息
     */
    - (void)updatePhoneContact;
    
    
    /**
     授权并创建手机联系人到通讯录
     */
    - (BOOL)createPhoneContact;
    
    
    

@end

NS_ASSUME_NONNULL_END
