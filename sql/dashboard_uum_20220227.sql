-- ----------------------------
-- 1、部门表
-- ----------------------------
create sequence seq_uum_dept
 increment by 1
 start with 200
 nomaxvalue
 nominvalue
 cache 20;

create table uum_dept (
  dept_id           number(20)      not null,
  parent_id         number(20)      default 0,
  ancestors         varchar2(50)    default '',
  dept_name         varchar2(30)    default '',
  order_num         number(4)       default 0,
  leader            varchar2(20)    default null,
  phone             varchar2(11)    default null,
  email             varchar2(50)    default null,
  status            char(1)         default '0',
  del_flag          char(1)         default '0',
  create_by         varchar2(64)    default '',
  create_time 	    date,
  update_by         varchar2(64)    default '',
  update_time       date
);

alter table uum_dept add constraint pk_uum_dept primary key (dept_id);

comment on table  uum_dept              is '部门信息表';
comment on column uum_dept.dept_id      is '部门主键seq_uum_dept.nextval';
comment on column uum_dept.parent_id    is '父部门id';
comment on column uum_dept.ancestors    is '祖级列表';
comment on column uum_dept.dept_name    is '部门名称';
comment on column uum_dept.order_num    is '显示顺序';
comment on column uum_dept.leader       is '负责人';
comment on column uum_dept.phone        is '联系电话';
comment on column uum_dept.email        is '邮箱';
comment on column uum_dept.status       is '部门状态（0正常 1停用）';
comment on column uum_dept.del_flag     is '删除标志（0代表存在 2代表删除）';
comment on column uum_dept.create_by    is '创建者';
comment on column uum_dept.create_time  is '创建时间';
comment on column uum_dept.update_by    is '更新者';
comment on column uum_dept.update_time  is '更新时间';

-- ----------------------------
-- 初始化-部门表数据
-- ----------------------------
insert into uum_dept values(100,  0,   '0',          '若依科技',   0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate, '', null);
insert into uum_dept values(101,  100, '0,100',      '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate, '', null);
insert into uum_dept values(102,  100, '0,100',      '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate, '', null);
insert into uum_dept values(103,  101, '0,100,101',  '研发部门',   1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate, '', null);
insert into uum_dept values(104,  101, '0,100,101',  '市场部门',   2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate, '', null);
insert into uum_dept values(105,  101, '0,100,101',  '测试部门',   3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate, '', null);
insert into uum_dept values(106,  101, '0,100,101',  '财务部门',   4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate, '', null);
insert into uum_dept values(107,  101, '0,100,101',  '运维部门',   5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate, '', null);
insert into uum_dept values(108,  102, '0,100,102',  '市场部门',   1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate, '', null);
insert into uum_dept values(109,  102, '0,100,102',  '财务部门',   2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate, '', null);

-- ----------------------------
-- 2、用户信息表
-- ----------------------------
create sequence seq_uum_user
 increment by 1
 start with 100
 nomaxvalue
 nominvalue
 cache 20;

create table uum_user (
  user_id           number(20)      not null,
  dept_id           number(20)      default null,
  user_name         varchar2(30)    not null,
  nick_name         varchar2(30)    default '',
  user_type         varchar2(2)     default '00',
  email             varchar2(50)    default '',
  phonenumber       varchar2(11)    default '',
  sex               char(1)         default '0',
  avatar            varchar2(100)   default '',
  password          varchar2(100)   default '',
  status            char(1)         default '0',
  del_flag          char(1)         default '0',
  login_ip          varchar2(128)   default '',
  login_date        date,
  create_by         varchar2(64),
  create_time 	    date,
  update_by         varchar2(64)    default '',
  update_time       date,
  remark            varchar2(500)   default ''
);

alter table uum_user add constraint pk_uum_user primary key (user_id);

comment on table  uum_user              is '用户信息表';
comment on column uum_user.user_id      is '用户主键seq_uum_user.nextval';
comment on column uum_user.dept_id      is '部门ID';
comment on column uum_user.user_name    is '用户账号';
comment on column uum_user.nick_name    is '用户昵称';
comment on column uum_user.user_type    is '用户类型（00系统用户 01注册用户）';
comment on column uum_user.email        is '用户邮箱';
comment on column uum_user.phonenumber  is '手机号码';
comment on column uum_user.sex          is '用户性别（0男 1女 2未知）';
comment on column uum_user.avatar       is '头像路径';
comment on column uum_user.password     is '密码';
comment on column uum_user.status       is '帐号状态（0正常 1停用）';
comment on column uum_user.del_flag     is '删除标志（0代表存在 2代表删除）';
comment on column uum_user.login_ip     is '最后登录IP';
comment on column uum_user.login_date   is '最后登录时间';
comment on column uum_user.create_by    is '创建者';
comment on column uum_user.create_time  is '创建时间';
comment on column uum_user.update_by    is '更新者';
comment on column uum_user.update_time  is '更新时间';
comment on column uum_user.remark       is '备注';

-- ----------------------------
-- 初始化-用户信息表数据
-- ----------------------------
insert into uum_user values(1,  103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate, 'admin', sysdate, '', null, '管理员');
insert into uum_user values(2,  105, 'ry',    '若依', '00', 'ry@qq.com',  '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate, 'admin', sysdate, '', null, '测试员');


-- ----------------------------
-- 3、岗位信息表
-- ----------------------------
create sequence seq_uum_post
 increment by 1
 start with 10
 nomaxvalue
 nominvalue
 cache 20;

create table uum_post
(
  post_id           number(20)      not null,
  post_code         varchar2(64)    not null,
  post_name         varchar2(50)    not null,
  post_sort         number(4)       not null,
  status            char(1)         not null,
  create_by         varchar2(64)    default '',
  create_time       date,
  update_by         varchar2(64)    default '',
  update_time       date,
  remark            varchar2(500)
);

alter table uum_post add constraint pk_uum_post primary key (post_id);

comment on table  uum_post              is '岗位信息表';
comment on column uum_post.post_id      is '岗位主键seq_uum_post.nextval';
comment on column uum_post.post_code    is '岗位编码';
comment on column uum_post.post_name    is '岗位名称';
comment on column uum_post.post_sort    is '显示顺序';
comment on column uum_post.status       is '状态（0正常 1停用）';
comment on column uum_post.create_by    is '创建者';
comment on column uum_post.create_time  is '创建时间';
comment on column uum_post.update_by    is '更新者';
comment on column uum_post.update_time  is '更新时间';
comment on column uum_post.remark       is '备注';

-- ----------------------------
-- 初始化-岗位信息表数据
-- ----------------------------
insert into uum_post values(1, 'ceo',  '董事长',    1, '0', 'admin', sysdate, '', null, '');
insert into uum_post values(2, 'se',   '项目经理',  2, '0', 'admin', sysdate, '', null, '');
insert into uum_post values(3, 'hr',   '人力资源',  3, '0', 'admin', sysdate, '', null, '');
insert into uum_post values(4, 'user', '普通员工',  4, '0', 'admin', sysdate, '', null, '');


-- ----------------------------
-- 4、角色信息表
-- ----------------------------
create sequence seq_uum_role
 increment by 1
 start with 100
 nomaxvalue
 nominvalue
 cache 20;

create table uum_role (
  role_id              number(20)      not null,
  role_name            varchar2(30)    not null,
  role_key             varchar2(100)   not null,
  role_sort            number(4)       not null,
  data_scope           char(1)         default '1',
  menu_check_strictly  number(1)       default 1,
  dept_check_strictly  number(1)       default 1,
  status               char(1)         not null,
  del_flag             char(1)         default '0',
  create_by            varchar2(64)    default '',
  create_time          date,
  update_by            varchar2(64)    default '',
  update_time          date,
  remark               varchar2(500)   default null
);

alter table uum_role add constraint pk_uum_role primary key (role_id);

comment on table  uum_role                       is '角色信息表';
comment on column uum_role.role_id               is '角色主键seq_uum_post.nextval';
comment on column uum_role.role_name             is '角色名称';
comment on column uum_role.role_key              is '角色权限字符串';
comment on column uum_role.role_sort             is '显示顺序';
comment on column uum_role.data_scope            is '数据范围（1：全部数据权限 2：自定数据权限）';
comment on column uum_role.menu_check_strictly   is '菜单树选择项是否关联显示';
comment on column uum_role.dept_check_strictly   is '部门树选择项是否关联显示';
comment on column uum_role.status                is '角色状态（0正常 1停用）';
comment on column uum_role.del_flag              is '删除标志（0代表存在 2代表删除）';
comment on column uum_role.create_by             is '创建者';
comment on column uum_role.create_time           is '创建时间';
comment on column uum_role.update_by             is '更新者';
comment on column uum_role.update_time           is '更新时间';
comment on column uum_role.remark                is '备注';

-- ----------------------------
-- 初始化-角色信息表数据
-- ----------------------------
insert into uum_role values('1', '超级管理员', 'admin',  1, 1, 1, 1, '0', '0', 'admin', sysdate, '', null, '超级管理员');
insert into uum_role values('2', '普通角色',   'common', 2, 2, 1, 1, '0', '0', 'admin', sysdate, '', null, '普通角色');


-- ----------------------------
-- 5、菜单权限表
-- ----------------------------
create sequence seq_uum_menu
 increment by 1
 start with 2000
 nomaxvalue
 nominvalue
 cache 20;

create table uum_menu (
  menu_id           number(20)      not null,
  menu_name         varchar2(50)    not null,
  parent_id         number(20)      default 0,
  order_num         number(4)       default 0,
  path              varchar(200)    default '',
  component         varchar(255)    default null,
  query             varchar(255)    default null,
  is_frame          number(1)       default 1,
  is_cache          number(1)       default 0,
  menu_type         char(1)         default '',
  visible           char(1)         default 0,
  status            char(1)         default 0,
  perms             varchar2(100)   default null,
  icon              varchar2(100)   default '#',
  create_by         varchar2(64)    default '',
  create_time       date,
  update_by         varchar2(64)    default '',
  update_time       date ,
  remark            varchar2(500)   default ''
);

alter table uum_menu add constraint pk_uum_menu primary key (menu_id);

comment on table  uum_menu              is '菜单权限表';
comment on column uum_menu.menu_id      is '菜单主键seq_uum_post.nextval';
comment on column uum_menu.menu_name    is '菜单名称';
comment on column uum_menu.parent_id    is '父菜单ID';
comment on column uum_menu.order_num    is '显示顺序';
comment on column uum_menu.path         is '请求地址';
comment on column uum_menu.component    is '路由地址';
comment on column uum_menu.query        is '路由参数';
comment on column uum_menu.is_frame     is '是否为外链（0是 1否）';
comment on column uum_menu.is_cache     is '是否缓存（0缓存 1不缓存）';
comment on column uum_menu.menu_type    is '菜单类型（M目录 C菜单 F按钮）';
comment on column uum_menu.visible      is '菜单状态（0显示 1隐藏）';
comment on column uum_menu.status       is '菜单状态（0正常 1停用）';
comment on column uum_menu.perms        is '权限标识';
comment on column uum_menu.icon         is '菜单图标';
comment on column uum_menu.create_by    is '创建者';
comment on column uum_menu.create_time  is '创建时间';
comment on column uum_menu.update_by    is '更新者';
comment on column uum_menu.update_time  is '更新时间';
comment on column uum_menu.remark       is '备注';

-- ----------------------------
-- 初始化-菜单信息表数据
-- ----------------------------
-- 一级菜单
insert into uum_menu values('1', '系统管理', '0', '1', 'system',           null, '', 1, 0, 'M', '0', '0', '', 'system',   'admin', sysdate, '', null, '系统管理目录');
insert into uum_menu values('2', '系统监控', '0', '2', 'monitor',          null, '', 1, 0, 'M', '0', '0', '', 'monitor',  'admin', sysdate, '', null, '系统监控目录');
insert into uum_menu values('3', '系统工具', '0', '3', 'tool',             null, '', 1, 0, 'M', '0', '0', '', 'tool',     'admin', sysdate, '', null, '系统工具目录');
insert into uum_menu values('4', '若依官网', '0', '4', 'http://ruoyi.vip', null, '', 0, 0, 'M', '0', '0', '', 'guide',    'admin', sysdate, '', null, '若依官网地址');
-- 二级菜单
insert into uum_menu values('100',  '用户管理', '1',   '1', 'user',       'system/user/index',        '', 1, 0, 'C', '0', '0', 'system:user:list',        'user',          'admin', sysdate, '', null, '用户管理菜单');
insert into uum_menu values('101',  '角色管理', '1',   '2', 'role',       'system/role/index',        '', 1, 0, 'C', '0', '0', 'system:role:list',        'peoples',       'admin', sysdate, '', null, '角色管理菜单');
insert into uum_menu values('102',  '菜单管理', '1',   '3', 'menu',       'system/menu/index',        '', 1, 0, 'C', '0', '0', 'system:menu:list',        'tree-table',    'admin', sysdate, '', null, '菜单管理菜单');
insert into uum_menu values('103',  '部门管理', '1',   '4', 'dept',       'system/dept/index',        '', 1, 0, 'C', '0', '0', 'system:dept:list',        'tree',          'admin', sysdate, '', null, '部门管理菜单');
insert into uum_menu values('104',  '岗位管理', '1',   '5', 'post',       'system/post/index',        '', 1, 0, 'C', '0', '0', 'system:post:list',        'post',          'admin', sysdate, '', null, '岗位管理菜单');
insert into uum_menu values('105',  '字典管理', '1',   '6', 'dict',       'system/dict/index',        '', 1, 0, 'C', '0', '0', 'system:dict:list',        'dict',          'admin', sysdate, '', null, '字典管理菜单');
insert into uum_menu values('106',  '参数设置', '1',   '7', 'config',     'system/config/index',      '', 1, 0, 'C', '0', '0', 'system:config:list',      'edit',          'admin', sysdate, '', null, '参数设置菜单');
insert into uum_menu values('107',  '通知公告', '1',   '8', 'notice',     'system/notice/index',      '', 1, 0, 'C', '0', '0', 'system:notice:list',      'message',       'admin', sysdate, '', null, '通知公告菜单');
insert into uum_menu values('108',  '日志管理', '1',   '9', 'log',        '',                         '', 1, 0, 'M', '0', '0', '',                        'log',           'admin', sysdate, '', null, '日志管理菜单');
insert into uum_menu values('109',  '在线用户', '2',   '1', 'online',     'monitor/online/index',     '', 1, 0, 'C', '0', '0', 'monitor:online:list',     'online',        'admin', sysdate, '', null, '在线用户菜单');
insert into uum_menu values('110',  '定时任务', '2',   '2', 'job',        'monitor/job/index',        '', 1, 0, 'C', '0', '0', 'monitor:job:list',        'job',           'admin', sysdate, '', null, '定时任务菜单');
insert into uum_menu values('111',  '数据监控', '2',   '3', 'druid',      'monitor/druid/index',      '', 1, 0, 'C', '0', '0', 'monitor:druid:list',      'druid',         'admin', sysdate, '', null, '数据监控菜单');
insert into uum_menu values('112',  '服务监控', '2',   '4', 'server',     'monitor/server/index',     '', 1, 0, 'C', '0', '0', 'monitor:server:list',     'server',        'admin', sysdate, '', null, '服务监控菜单');
insert into uum_menu values('113',  '缓存监控', '2',   '5', 'cache',      'monitor/cache/index',      '', 1, 0, 'C', '0', '0', 'monitor:cache:list',      'redis',         'admin', sysdate, '', null, '缓存监控菜单');
insert into uum_menu values('114',  '表单构建', '3',   '1', 'build',      'tool/build/index',         '', 1, 0, 'C', '0', '0', 'tool:build:list',         'build',         'admin', sysdate, '', null, '表单构建菜单');
insert into uum_menu values('115',  '代码生成', '3',   '2', 'gen',        'tool/gen/index',           '', 1, 0, 'C', '0', '0', 'tool:gen:list',           'code',          'admin', sysdate, '', null, '代码生成菜单');
insert into uum_menu values('116',  '系统接口', '3',   '3', 'swagger',    'tool/swagger/index',       '', 1, 0, 'C', '0', '0', 'tool:swagger:list',       'swagger',       'admin', sysdate, '', null, '系统接口菜单');
-- 三级菜单
insert into uum_menu values('500',  '操作日志', '108', '1', 'operlog',    'monitor/operlog/index',    '', 1, 0, 'C', '0', '0', 'monitor:operlog:list',    'form',          'admin', sysdate, '', null, '操作日志菜单');
insert into uum_menu values('501',  '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor',    'admin', sysdate, '', null, '登录日志菜单');
-- 用户管理按钮
insert into uum_menu values('1001', '用户查询', '100', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:query',          '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1002', '用户新增', '100', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:add',            '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1003', '用户修改', '100', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit',           '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1004', '用户删除', '100', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove',         '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1005', '用户导出', '100', '5',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:export',         '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1006', '用户导入', '100', '6',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:import',         '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1007', '重置密码', '100', '7',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd',       '#', 'admin', sysdate, '', null, '');
-- 角色管理按钮
insert into uum_menu values('1008', '角色查询', '101', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:query',          '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1009', '角色新增', '101', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:add',            '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1010', '角色修改', '101', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit',           '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1011', '角色删除', '101', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove',         '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1012', '角色导出', '101', '5',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:export',         '#', 'admin', sysdate, '', null, '');
-- 菜单管理按钮
insert into uum_menu values('1013', '菜单查询', '102', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query',          '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1014', '菜单新增', '102', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add',            '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1015', '菜单修改', '102', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit',           '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1016', '菜单删除', '102', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove',         '#', 'admin', sysdate, '', null, '');
-- 部门管理按钮
insert into uum_menu values('1017', '部门查询', '103', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query',          '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1018', '部门新增', '103', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add',            '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1019', '部门修改', '103', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit',           '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1020', '部门删除', '103', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove',         '#', 'admin', sysdate, '', null, '');
-- 岗位管理按钮
insert into uum_menu values('1021', '岗位查询', '104', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:query',          '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1022', '岗位新增', '104', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:add',            '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1023', '岗位修改', '104', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit',           '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1024', '岗位删除', '104', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove',         '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1025', '岗位导出', '104', '5',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:export',         '#', 'admin', sysdate, '', null, '');
-- 字典管理按钮
insert into uum_menu values('1026', '字典查询', '105', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query',          '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1027', '字典新增', '105', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add',            '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1028', '字典修改', '105', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit',           '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1029', '字典删除', '105', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove',         '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1030', '字典导出', '105', '5', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export',         '#', 'admin', sysdate, '', null, '');
-- 参数设置按钮
insert into uum_menu values('1031', '参数查询', '106', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query',        '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1032', '参数新增', '106', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add',          '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1033', '参数修改', '106', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit',         '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1034', '参数删除', '106', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove',       '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1035', '参数导出', '106', '5', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export',       '#', 'admin', sysdate, '', null, '');
-- 通知公告按钮
insert into uum_menu values('1036', '公告查询', '107', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query',        '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1037', '公告新增', '107', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add',          '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1038', '公告修改', '107', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit',         '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1039', '公告删除', '107', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove',       '#', 'admin', sysdate, '', null, '');
-- 操作日志按钮
insert into uum_menu values('1040', '操作查询', '500', '1', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query',      '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1041', '操作删除', '500', '2', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove',     '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1042', '日志导出', '500', '4', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export',     '#', 'admin', sysdate, '', null, '');
-- 登录日志按钮
insert into uum_menu values('1043', '登录查询', '501', '1', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query',   '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1044', '登录删除', '501', '2', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove',  '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1045', '日志导出', '501', '3', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export',  '#', 'admin', sysdate, '', null, '');
-- 在线用户按钮
insert into uum_menu values('1046', '在线查询', '109', '1', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query',       '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1047', '批量强退', '109', '2', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1048', '单条强退', '109', '3', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', sysdate, '', null, '');
-- 定时任务按钮
insert into uum_menu values('1049', '任务查询', '110', '1', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query',          '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1050', '任务新增', '110', '2', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add',            '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1051', '任务修改', '110', '3', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit',           '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1052', '任务删除', '110', '4', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove',         '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1053', '状态修改', '110', '5', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus',   '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1054', '任务导出', '110', '7', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export',         '#', 'admin', sysdate, '', null, '');
-- 代码生成按钮
insert into uum_menu values('1055', '生成查询', '115', '1', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query',             '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1056', '生成修改', '115', '2', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit',              '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1057', '生成删除', '115', '3', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove',            '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1058', '导入代码', '115', '2', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import',            '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1059', '预览代码', '115', '4', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview',           '#', 'admin', sysdate, '', null, '');
insert into uum_menu values('1060', '生成代码', '115', '5', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code',              '#', 'admin', sysdate, '', null, '');


-- ----------------------------
-- 6、用户和角色关联表  用户N-1角色
-- ----------------------------
create table uum_user_role (
  user_id 	number(20)  not null,
  role_id 	number(20)  not null
);

alter table uum_user_role add constraint pk_uum_user_role primary key (user_id, role_id);

comment on table  uum_user_role              is '用户和角色关联表';
comment on column uum_user_role.user_id      is '用户ID';
comment on column uum_user_role.role_id      is '角色ID';

-- ----------------------------
-- 初始化-用户和角色关联表数据
-- ----------------------------
insert into uum_user_role values ('1', '1');
insert into uum_user_role values ('2', '2');


-- ----------------------------
-- 7、角色和菜单关联表  角色1-N菜单
-- ----------------------------
create table uum_role_menu (
  role_id 	number(20)  not null,
  menu_id 	number(20)  not null
);

alter table uum_role_menu add constraint pk_uum_role_menu primary key (role_id, menu_id);

comment on table  uum_role_menu              is '角色和菜单关联表';
comment on column uum_role_menu.role_id      is '角色ID';
comment on column uum_role_menu.menu_id      is '菜单ID';

-- ----------------------------
-- 初始化-角色和菜单关联表数据
-- ----------------------------
insert into uum_role_menu values ('2', '1');
insert into uum_role_menu values ('2', '2');
insert into uum_role_menu values ('2', '3');
insert into uum_role_menu values ('2', '4');
insert into uum_role_menu values ('2', '100');
insert into uum_role_menu values ('2', '101');
insert into uum_role_menu values ('2', '102');
insert into uum_role_menu values ('2', '103');
insert into uum_role_menu values ('2', '104');
insert into uum_role_menu values ('2', '105');
insert into uum_role_menu values ('2', '106');
insert into uum_role_menu values ('2', '107');
insert into uum_role_menu values ('2', '108');
insert into uum_role_menu values ('2', '109');
insert into uum_role_menu values ('2', '110');
insert into uum_role_menu values ('2', '111');
insert into uum_role_menu values ('2', '112');
insert into uum_role_menu values ('2', '113');
insert into uum_role_menu values ('2', '114');
insert into uum_role_menu values ('2', '115');
insert into uum_role_menu values ('2', '116');
insert into uum_role_menu values ('2', '500');
insert into uum_role_menu values ('2', '501');
insert into uum_role_menu values ('2', '1000');
insert into uum_role_menu values ('2', '1001');
insert into uum_role_menu values ('2', '1002');
insert into uum_role_menu values ('2', '1003');
insert into uum_role_menu values ('2', '1004');
insert into uum_role_menu values ('2', '1005');
insert into uum_role_menu values ('2', '1006');
insert into uum_role_menu values ('2', '1007');
insert into uum_role_menu values ('2', '1008');
insert into uum_role_menu values ('2', '1009');
insert into uum_role_menu values ('2', '1010');
insert into uum_role_menu values ('2', '1011');
insert into uum_role_menu values ('2', '1012');
insert into uum_role_menu values ('2', '1013');
insert into uum_role_menu values ('2', '1014');
insert into uum_role_menu values ('2', '1015');
insert into uum_role_menu values ('2', '1016');
insert into uum_role_menu values ('2', '1017');
insert into uum_role_menu values ('2', '1018');
insert into uum_role_menu values ('2', '1019');
insert into uum_role_menu values ('2', '1020');
insert into uum_role_menu values ('2', '1021');
insert into uum_role_menu values ('2', '1022');
insert into uum_role_menu values ('2', '1023');
insert into uum_role_menu values ('2', '1024');
insert into uum_role_menu values ('2', '1025');
insert into uum_role_menu values ('2', '1026');
insert into uum_role_menu values ('2', '1027');
insert into uum_role_menu values ('2', '1028');
insert into uum_role_menu values ('2', '1029');
insert into uum_role_menu values ('2', '1030');
insert into uum_role_menu values ('2', '1031');
insert into uum_role_menu values ('2', '1032');
insert into uum_role_menu values ('2', '1033');
insert into uum_role_menu values ('2', '1034');
insert into uum_role_menu values ('2', '1035');
insert into uum_role_menu values ('2', '1036');
insert into uum_role_menu values ('2', '1037');
insert into uum_role_menu values ('2', '1038');
insert into uum_role_menu values ('2', '1039');
insert into uum_role_menu values ('2', '1040');
insert into uum_role_menu values ('2', '1041');
insert into uum_role_menu values ('2', '1042');
insert into uum_role_menu values ('2', '1043');
insert into uum_role_menu values ('2', '1044');
insert into uum_role_menu values ('2', '1045');
insert into uum_role_menu values ('2', '1046');
insert into uum_role_menu values ('2', '1047');
insert into uum_role_menu values ('2', '1048');
insert into uum_role_menu values ('2', '1049');
insert into uum_role_menu values ('2', '1050');
insert into uum_role_menu values ('2', '1051');
insert into uum_role_menu values ('2', '1052');
insert into uum_role_menu values ('2', '1053');
insert into uum_role_menu values ('2', '1054');
insert into uum_role_menu values ('2', '1055');
insert into uum_role_menu values ('2', '1056');
insert into uum_role_menu values ('2', '1057');
insert into uum_role_menu values ('2', '1058');
insert into uum_role_menu values ('2', '1059');
insert into uum_role_menu values ('2', '1060');

-- ----------------------------
-- 8、角色和部门关联表  角色1-N部门
-- ----------------------------
create table uum_role_dept (
  role_id 	number(20)  not null,
  dept_id 	number(20)  not null
);

alter table uum_role_dept add constraint pk_uum_role_dept primary key (role_id, dept_id);

comment on table  uum_role_dept              is '角色和部门关联表';
comment on column uum_role_dept.role_id      is '角色ID';
comment on column uum_role_dept.dept_id      is '部门ID';

-- ----------------------------
-- 初始化-角色和部门关联表数据
-- ----------------------------
insert into uum_role_dept values ('2', '100');
insert into uum_role_dept values ('2', '101');
insert into uum_role_dept values ('2', '105');

-- ----------------------------
-- 9、用户与岗位关联表  用户1-N岗位
-- ----------------------------
create table uum_user_post
(
	user_id number(20)  not null,
	post_id number(20)  not null
);

alter table uum_user_post add constraint pk_uum_user_post primary key (user_id, post_id);

comment on table  uum_user_post              is '用户与岗位关联表';
comment on column uum_user_post.user_id      is '用户ID';
comment on column uum_user_post.post_id      is '岗位ID';

-- ----------------------------
-- 初始化-用户与岗位关联表数据
-- ----------------------------
insert into uum_user_post values ('1', '1');
insert into uum_user_post values ('2', '2');


-- ----------------------------
-- 10、操作日志记录
-- ----------------------------
create sequence seq_uum_oper_log
 increment by 1
 start with 100
 nomaxvalue
 nominvalue
 cache 20;

create table uum_oper_log (
  oper_id           number(20)      not null ,
  title             varchar2(50)    default '',
  business_type     number(2)       default 0,
  method            varchar2(100)   default '',
  request_method    varchar(10)     default '',
  operator_type     number(1)       default 0,
  oper_name         varchar2(50)    default '',
  dept_name         varchar2(50)    default '',
  oper_url          varchar2(255) 	default '',
  oper_ip           varchar2(128)   default '',
  oper_location     varchar2(255)   default '',
  oper_param        varchar2(4000)  default '',
  json_result       varchar2(2000)  default '',
  status            number(1)       default 0,
  error_msg         varchar2(2000)  default '' ,
  oper_time         date
);

alter table uum_oper_log add constraint pk_uum_oper_log primary key (oper_id);

comment on table  uum_oper_log                is '操作日志记录';
comment on column uum_oper_log.oper_id        is '日志主键seq_uum_oper_log.nextval';
comment on column uum_oper_log.title          is '模块标题';
comment on column uum_oper_log.business_type  is '业务类型（0其它 1新增 2修改 3删除）';
comment on column uum_oper_log.method         is '方法名称';
comment on column uum_oper_log.request_method is '请求方式';
comment on column uum_oper_log.operator_type  is '操作类别（0其它 1后台用户 2手机端用户）';
comment on column uum_oper_log.oper_name      is '操作人员';
comment on column uum_oper_log.dept_name      is '部门名称';
comment on column uum_oper_log.oper_url       is '请求URL';
comment on column uum_oper_log.oper_ip        is '主机地址';
comment on column uum_oper_log.oper_location  is '操作地点';
comment on column uum_oper_log.oper_param     is '请求参数';
comment on column uum_oper_log.json_result    is '返回参数';
comment on column uum_oper_log.status         is '操作状态（0正常 1异常）';
comment on column uum_oper_log.error_msg      is '错误消息';
comment on column uum_oper_log.oper_time      is '操作时间';


-- ----------------------------
-- 14、系统访问记录
-- ----------------------------
create sequence seq_uum_logininfor
 increment by 1
 start with 100
 nomaxvalue
 nominvalue
 cache 20;

create table uum_logininfor (
  info_id         number(20)     not null,
  user_name       varchar2(50)   default '',
  ipaddr          varchar2(128)  default '',
  login_location  varchar2(255)  default '',
  browser         varchar2(50)   default '',
  os              varchar2(50)   default '',
  status          char(1)        default '0',
  msg             varchar2(255)  default '',
  login_time      date
);

alter table uum_logininfor add constraint pk_uum_logininfor primary key (info_id);

comment on table  uum_logininfor                is '系统访问记录';
comment on column uum_logininfor.info_id        is '访问主键seq_seq_uum_logininfor.nextval';
comment on column uum_logininfor.user_name      is '登录账号';
comment on column uum_logininfor.ipaddr         is '登录IP地址';
comment on column uum_logininfor.login_location is '登录地点';
comment on column uum_logininfor.browser        is '浏览器类型';
comment on column uum_logininfor.os             is '操作系统';
comment on column uum_logininfor.status         is '登录状态（0成功 1失败）';
comment on column uum_logininfor.msg            is '提示消息';
comment on column uum_logininfor.login_time     is '访问时间';
