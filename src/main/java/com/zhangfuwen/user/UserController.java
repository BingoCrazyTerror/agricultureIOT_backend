package com.zhangfuwen.user;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

/**
 * Created by dean on 3/26/17.
 */
@Controller
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private UserService userService;
    @Autowired
    private SysRoleService roleService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");

        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");

        return "login";
    }

    @RequestMapping(value = {"/user/profile"}, method = RequestMethod.GET)
    public String reset_password(@RequestParam String username, Model model) {
        SysUser user = userService.findByUsername(username);
        model.addAttribute("user", user);
        return "user-edit";
    }

    //管理员可以修改用户密码，用户自己可以修改密码
    @RequestMapping(value = {"/user/password"}, method = RequestMethod.GET)
    public String reset_password( Model model,HttpServletRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        SysUser user = (SysUser) auth.getPrincipal();
        if(request.isUserInRole("CREATOR") || request.isUserInRole("ADMIN"))
        {
            model.addAttribute("admin", true);
        }
        model.addAttribute("username", user.getUsername());
        return "reset-password";
    }

    @RequestMapping(value = {"/flash"}, method = RequestMethod.GET)
    public String flash()
    {
        return "flash";
    }

    @RequestMapping(value = {"/user/password"}, method = RequestMethod.POST)
    public String modify_password(@ModelAttribute("userForm") SysUser userForm,
                                  BindingResult bindingResult,
                                  HttpServletRequest request,
                                  final RedirectAttributes redirectAttributes
                                  ) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        SysUser user = (SysUser) auth.getPrincipal();

        logger.info(""+user.getUsername() +"  " + userForm.getUsername());
        if (!(user.getUsername().equals(userForm.getUsername()) ||
                request.isUserInRole("ROLE_CREATOR") ||
                request.isUserInRole("ROLE_ADMIN"))) {
            String referer = request.getHeader("Referer");
            redirectAttributes.addFlashAttribute("message", "你无权执行此操作");
            redirectAttributes.addFlashAttribute("referer", referer);
            return "redirect:/flash";
        }
        userValidator.validate(userForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "reset-password";
        }

        String referer = request.getHeader("Referer");
        redirectAttributes.addFlashAttribute("message", "修改密码成功");
        redirectAttributes.addFlashAttribute("referer", "/index");
        //显示修改密码页面
        return "redirect:/flash";
    }


    /* 以下为用户客理 */
    @RequestMapping(value = {"/users"}, method = RequestMethod.GET)
    public String users(Model model) {
        model.addAttribute("users", userService.listUsers());
        return "users";
    }

    @RequestMapping(value = {"/users/manage"}, method = RequestMethod.GET)
    public String edit_user(@RequestParam String username, Model model) {
        model.addAttribute("user", userService.findByUsername(username));
        return "user-edit";
    }

    @RequestMapping(value = {"/users/delete"}, method = RequestMethod.POST)
    public String delete_user(@RequestParam String username) {
        userService.deleteByUsername(username);
        return "redirect:/users";
    }

    @RequestMapping(value = {"/users/promote"}, method = RequestMethod.POST)
    public String promote_user(@RequestParam String username, @RequestParam String role, Model model) {
        Long role_id;
        if (role.equals("admin")) {
            role_id = new Long(2);
        } else if (role.equals("expert")) {
            role_id = new Long(3);
        } else {
            return "error";
        }
        SysUser user = userService.findByUsername(username);
        user.getRoles().clear();
        SysRole newRole = roleService.getRoleById(role_id);
        user.getRoles().add(newRole);

        userService.save(user);
        model.addAttribute("user", userService.findByUsername(username));
        return "redirect:/users";
    }

    @RequestMapping(value = {"/users/demote"}, method = RequestMethod.POST)
    public String demote_user(@RequestParam String username, Model model) {
        SysUser user = userService.findByUsername(username);
        user.getRoles().clear();
        SysRole newRole = roleService.getRoleById(new Long(4));
        user.getRoles().add(newRole);
        userService.save(user);
        model.addAttribute("user", userService.findByUsername(username));
        return "redirect:/users";
    }

    @RequestMapping(value = "/users/add", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new SysUser());
        return "sign-up";
    }

    @RequestMapping(value = "/users/add", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") SysUser userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);
        logger.info(bindingResult.getAllErrors().toString());
        if (bindingResult.hasErrors()) {
            return "sign-up";
        }
        //defaults to normal user
        userForm.setRoles(new ArrayList<>());
        SysRole role = roleService.getRoleById(new Long(4));
        userForm.getRoles().add(role);
        userService.save(userForm);
        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());
        return "redirect:/index";
    }
}
