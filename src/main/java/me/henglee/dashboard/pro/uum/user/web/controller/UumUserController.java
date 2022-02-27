package me.henglee.dashboard.pro.uum.user.web.controller;

import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import me.henglee.dashboard.pro.freamwork.common.constant.UumUserConstants;
import me.henglee.dashboard.pro.freamwork.common.utils.StringUtils;
import me.henglee.dashboard.pro.freamwork.common.utils.UumSecurityUtils;
import me.henglee.dashboard.pro.freamwork.common.utils.poi.ExcelUtil;
import me.henglee.dashboard.pro.freamwork.controller.BaseController;
import me.henglee.dashboard.pro.freamwork.domain.AjaxResult;
import me.henglee.dashboard.pro.freamwork.page.TableDataInfo;
import me.henglee.dashboard.pro.uum.post.service.internal.IUumPostService;
import me.henglee.dashboard.pro.uum.role.domain.pojo.UumRole;
import me.henglee.dashboard.pro.uum.role.service.internal.IUumRoleService;
import me.henglee.dashboard.pro.uum.user.domain.pojo.UumUser;
import me.henglee.dashboard.pro.uum.user.service.internal.IUumUserService;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 用户信息
 * 
 * @author Andy.ma
 */
@RestController
@RequestMapping("/uum/user")
public class UumUserController extends BaseController
{
    @Autowired
    private IUumUserService userService;

    @Autowired
    private IUumRoleService roleService;

    @Autowired
    private IUumPostService postService;

    /**
     * 获取用户列表
     */
   // @PreAuthorize("@ss.hasPermi('uum:user:list')")
    @GetMapping("/list")
    public TableDataInfo list(UumUser user)
    {
        startPage();
        List<UumUser> list = userService.selectUserList(user);
        return getDataTable(list);
    }

    @Log (title = "用户管理", businessType = BusinessType.EXPORT)
   // @PreAuthorize("@ss.hasPermi('uum:user:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, UumUser user)
    {
        List<UumUser> list = userService.selectUserList(user);
        ExcelUtil<UumUser> util = new ExcelUtil<UumUser>(UumUser.class);
        util.exportExcel(response, list, "用户数据");
    }

    @Log(title = "用户管理", businessType = BusinessType.IMPORT)
   // @PreAuthorize("@ss.hasPermi('uum:user:import')")
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception
    {
        ExcelUtil<UumUser> util = new ExcelUtil<UumUser>(UumUser.class);
        List<UumUser> userList = util.importExcel(file.getInputStream());
        String operName = getUsername();
        String message = userService.importUser(userList, updateSupport, operName);
        return AjaxResult.success(message);
    }

    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response)
    {
        ExcelUtil<UumUser> util = new ExcelUtil<UumUser>(UumUser.class);
        util.importTemplateExcel(response, "用户数据");
    }

    /**
     * 根据用户编号获取详细信息
     */
   // @PreAuthorize("@ss.hasPermi('uum:user:query')")
    @GetMapping(value = { "/", "/{userId}" })
    public AjaxResult getInfo(@PathVariable(value = "userId", required = false) Long userId)
    {
        userService.checkUserDataScope(userId);
        AjaxResult ajax = AjaxResult.success();
        List<UumRole> roles = roleService.selectRoleAll();
        ajax.put("roles", UumUser.isAdmin(userId) ? roles : roles.stream().filter(r -> !r.isAdmin()).collect(Collectors.toList()));
        ajax.put("posts", postService.selectPostAll());
        if (StringUtils.isNotNull(userId))
        {
            UumUser sysUser = userService.selectUserById(userId);
            ajax.put(AjaxResult.DATA_TAG, sysUser);
            ajax.put("postIds", postService.selectPostListByUserId(userId));
            ajax.put("roleIds", sysUser.getRoles().stream().map(UumRole::getRoleId).collect(Collectors.toList()));
        }
        return ajax;
    }

    /**
     * 新增用户
     */
   // @PreAuthorize("@ss.hasPermi('uum:user:add')")
    @Log(title = "用户管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody UumUser user)
    {
        if (UumUserConstants.NOT_UNIQUE.equals(userService.checkUserNameUnique(user.getUserName())))
        {
            return AjaxResult.error("新增用户'" + user.getUserName() + "'失败，登录账号已存在");
        }
        else if (StringUtils.isNotEmpty(user.getPhonenumber())
                && UumUserConstants.NOT_UNIQUE.equals(userService.checkPhoneUnique(user)))
        {
            return AjaxResult.error("新增用户'" + user.getUserName() + "'失败，手机号码已存在");
        }
        else if (StringUtils.isNotEmpty(user.getEmail())
                && UumUserConstants.NOT_UNIQUE.equals(userService.checkEmailUnique(user)))
        {
            return AjaxResult.error("新增用户'" + user.getUserName() + "'失败，邮箱账号已存在");
        }
        user.setCreateBy(getUsername());
        user.setPassword(UumSecurityUtils.encryptPassword(user.getPassword()));
        return toAjax(userService.insertUser(user));
    }

    /**
     * 修改用户
     */
   // @PreAuthorize("@ss.hasPermi('uum:user:edit')")
    @Log(title = "用户管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody UumUser user)
    {
        userService.checkUserAllowed(user);
        userService.checkUserDataScope(user.getUserId());
        if (StringUtils.isNotEmpty(user.getPhonenumber())
                && UumUserConstants.NOT_UNIQUE.equals(userService.checkPhoneUnique(user)))
        {
            return AjaxResult.error("修改用户'" + user.getUserName() + "'失败，手机号码已存在");
        }
        else if (StringUtils.isNotEmpty(user.getEmail())
                && UumUserConstants.NOT_UNIQUE.equals(userService.checkEmailUnique(user)))
        {
            return AjaxResult.error("修改用户'" + user.getUserName() + "'失败，邮箱账号已存在");
        }
        user.setUpdateBy(getUsername());
        return toAjax(userService.updateUser(user));
    }

    /**
     * 删除用户
     */
   // @PreAuthorize("@ss.hasPermi('uum:user:remove')")
    @Log(title = "用户管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{userIds}")
    public AjaxResult remove(@PathVariable Long[] userIds)
    {
        if (ArrayUtils.contains(userIds, getUserId()))
        {
            return error("当前用户不能删除");
        }
        return toAjax(userService.deleteUserByIds(userIds));
    }

    /**
     * 重置密码
     */
   // @PreAuthorize("@ss.hasPermi('uum:user:resetPwd')")
    @Log(title = "用户管理", businessType = BusinessType.UPDATE)
    @PutMapping("/resetPwd")
    public AjaxResult resetPwd(@RequestBody UumUser user)
    {
        userService.checkUserAllowed(user);
        userService.checkUserDataScope(user.getUserId());
        user.setPassword(UumSecurityUtils.encryptPassword(user.getPassword()));
        user.setUpdateBy(getUsername());
        return toAjax(userService.resetPwd(user));
    }

    /**
     * 状态修改
     */
   // @PreAuthorize("@ss.hasPermi('uum:user:edit')")
    @Log(title = "用户管理", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public AjaxResult changeStatus(@RequestBody UumUser user)
    {
        userService.checkUserAllowed(user);
        userService.checkUserDataScope(user.getUserId());
        user.setUpdateBy(getUsername());
        return toAjax(userService.updateUserStatus(user));
    }

    /**
     * 根据用户编号获取授权角色
     */
   // @PreAuthorize("@ss.hasPermi('uum:user:query')")
    @GetMapping("/authRole/{userId}")
    public AjaxResult authRole(@PathVariable("userId") Long userId)
    {
        AjaxResult ajax = AjaxResult.success();
        UumUser user = userService.selectUserById(userId);
        List<UumRole> roles = roleService.selectRolesByUserId(userId);
        ajax.put("user", user);
        ajax.put("roles", UumUser.isAdmin(userId) ? roles : roles.stream().filter(r -> !r.isAdmin()).collect(Collectors.toList()));
        return ajax;
    }

    /**
     * 用户授权角色
     */
   // @PreAuthorize("@ss.hasPermi('uum:user:edit')")
    @Log(title = "用户管理", businessType = BusinessType.GRANT)
    @PutMapping("/authRole")
    public AjaxResult insertAuthRole(Long userId, Long[] roleIds)
    {
        userService.checkUserDataScope(userId);
        userService.insertUserAuth(userId, roleIds);
        return success();
    }
}