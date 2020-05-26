//
//  APIString.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2019/9/9.
//  Copyright © 2019年 梦境网络. All rights reserved.
//

#ifndef APIString_h
#define APIString_h

//#define SERVER_URL @"http://192.168.0.28:8085/userApp/"
#define SERVER_URL @"http://123.56.153.251:8085/"

//#define IMAGE_URL @"http://192.168.0.28:8085/userApp/FILE_UPLOAD"
#define IMAGE_URL @"http://123.56.153.251:8085/appUpload/FILE_UPLOAD"



/**
 用户及个人中心模块
 */
//用户登陆

#define  login_url  @"userApp/login"
//退出登录

#define  exit_url  @"userApp/exit"
//修改密码

#define  UPDATE_PC_url  @"userApp/UPDATE_PC"
//验证密码

#define  UPDATE_PHONE_url  @"userApp/UPDATE_PHONE"
//修改手机号

#define  registers_url  @"userApp/registers"
//查找个人信息

#define  SELECT_USERINFO_url  @"userApp/SELECT_USERINFO"
//认祖信息

#define  selectByApply_url  @"apply/selectByApply"
//通过和驳回

#define  update_url  @"apply/update"
//修改个人资料

#define  UPDATE_ZJ_url  @"userApp/UPDATE_ZJ"




//2.4.1 查询省
#define SELECT_PROVINCE_URL  @"userApp/SELECT_PROVINCE"
//2.5.1 查询市
#define SELECT_CITY_URL  @"userApp/SELECT_CITY"
//2.6.1 查询区
#define SELECT_AREA_URL  @"userApp/SELECT_AREA"






//创建家族
#define JS_CREATE_FAMILY_URL @"appJz/addJz"
//族谱列表&寻找家族$家族详情
#define JS_FAMILY_LIST_URL @"appJz/selectByUser"
//查看族谱列表
#define JS_SELECT_ZPLIST_URL @"appZp/selectByAppZuPu"
//查看祠堂列表
#define JS_SELECT_CTLIST_URL @"appCt/selectByAppCiTang"
//添加上一代or下一代
#define JS_ADD_NEWMEMBER_URL @"appZp/addAppZuPu"
//系统消息
#define JS_SYSMESSAGE_LILST_URL @"appPushRecord/list"
//申请查看族谱
#define JS_APPLYZP_URL @"apply/insert"
//获取回话列表
#define JS_GETCONVERSATION_URL @"userApp/BASE_PHONE_GAIN_MESSAGE"



#endif /* APIString_h */
