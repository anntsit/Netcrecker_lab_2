package edu.netcrecker.controller;

import edu.netcrecker.dao.EmployeeDao;
import edu.netcrecker.model.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.List;

@Controller
public class EmployeeController {
    @Autowired
    private EmployeeDao employeeDao;

    @Autowired
    private AuthenticationTrustResolver authenticationTrustResolver;


    @RequestMapping(value = "/")
    public ModelAndView listContact(ModelAndView model) throws IOException {
        List<Employee> listContact = employeeDao.list();
        model.addObject("listContact", listContact);
        model.addObject("loggedinuser", getPrincipal());
        model.setViewName("employee/employeeList");
        return model;
    }


    @RequestMapping(value = {"/delete-user-{objectId}"}, method = RequestMethod.GET)
    public String deleteUser(@PathVariable int objectId) {
        employeeDao.delete(objectId);
        return "redirect:/";
    }


    @RequestMapping(value = {"/newuser"}, method = RequestMethod.GET)
    public String newUser(ModelMap model) {
        Employee employee = new Employee();
        model.addAttribute("employee", employee);
        model.addAttribute("edit", false);
        model.addAttribute("loggedinuser", getPrincipal());
        return "employee/registration";
    }

    @RequestMapping(value = {"/newuser"}, method = RequestMethod.POST)
    public String saveUser(@Valid Employee employee, BindingResult result,
                           ModelMap model) {
        if (result.hasErrors()) {
            return "employee/registration";
        }
        employeeDao.insertEmplyee(employee);
        model.addAttribute("success", "User " + employee.getObject() + " registered successfully");
        model.addAttribute("loggedinuser", getPrincipal());
        return "employee/registrationsuccess";
    }

    @RequestMapping(value = {"/edit-user-{objectId}"}, method = RequestMethod.GET)
    public String editUser(@PathVariable int objectId, ModelMap model) {
        Employee employee = employeeDao.getEmployee(objectId);
        model.addAttribute("employee", employee);
        model.addAttribute("edit", true);
        model.addAttribute("loggedinuser", getPrincipal());
        return "employee/registration";
    }

    @RequestMapping(value = {"/edit-user-{objectId}"}, method = RequestMethod.POST)
    public String updateUser(@Valid @ModelAttribute("employee") Employee user, BindingResult result,
                             ModelMap model) {
        if (result.hasErrors()) {
            return "employee/registration";
        }
        employeeDao.Update(user);
        model.addAttribute("success", "User " + user.getObject() + " update successfully");
        model.addAttribute("loggedinuser", getPrincipal());
        return "employee/registrationsuccess";
    }


    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage() {
        if (isCurrentAuthenticationAnonymous()) {
            return "login";
        } else {
            return "redirect:/";
        }
    }
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logoutPage(HttpServletRequest request, HttpServletResponse response){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(authentication!=null){
            new SecurityContextLogoutHandler().logout(request,response,authentication);
        }
        return "redirect:/login?logout";
    }
    @ModelAttribute("roles")
    public List<Employee> findAllRolesIntoProject() {
        return employeeDao.getAllRoles();
    }

    @ModelAttribute("city")
    public List<Employee> findAllCityByDeptno() {
        return employeeDao.getAllCity();
    }

    private String getPrincipal() {
        String userName = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (principal instanceof UserDetails) {
            userName = ((UserDetails) principal).getUsername();
        } else {
            userName = principal.toString();
        }
        return userName;
    }

    private boolean isCurrentAuthenticationAnonymous() {
        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authenticationTrustResolver.isAnonymous(authentication);
    }
}

