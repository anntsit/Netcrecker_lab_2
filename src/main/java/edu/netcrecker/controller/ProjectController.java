package edu.netcrecker.controller;

import edu.netcrecker.dao.ProjectDao;
import edu.netcrecker.model.Employee;
import edu.netcrecker.model.Project;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.io.IOException;
import java.util.List;

@Controller
public class ProjectController {
    @Autowired
    private ProjectDao projectDao;

    @RequestMapping(value = "/listProjects")
    public ModelAndView listProjects(ModelAndView model) throws IOException {
        List<Project> listProjects = projectDao.projectList();
        model.addObject("listProjects", listProjects);
        model.setViewName("project/projectsList");
        model.addObject("loggedinuser", getPrincipal());
        return model;
    }

    @RequestMapping(value = {"/delete-project-{projectId}"}, method = RequestMethod.GET)
    public String deleteProject(@PathVariable int projectId) {
        projectDao.delete(projectId);
        return "redirect:/listProjects";
    }

    @RequestMapping(value = {"/newproject"}, method = RequestMethod.GET)
    public String newUser(ModelMap model) {
        Project project = new Project();
        model.addAttribute("project", project);
        model.addAttribute("edit", false);
        model.addAttribute("loggedinuser", getPrincipal());
        return "project/newproject";
    }

    @RequestMapping(value = {"/newproject"}, method = RequestMethod.POST)
    public String saveUser(@Valid Project project, BindingResult result,
                           ModelMap model) {
        if (result.hasErrors()) {
            return "project/newproject";
        }
        projectDao.insertProject(project);
        model.addAttribute("successproject", "Project " + project.getProjectName() + " registered successfully");
        return "project/projectsuccess";
    }


    @RequestMapping(value = {"/edit-project-{projectId}"}, method = RequestMethod.GET)
    public String editUser(@PathVariable int projectId, ModelMap model) {
        Project project = projectDao.getProject(projectId);
        model.addAttribute("project", project);
        model.addAttribute("edit", true);
        model.addAttribute("loggedinuser", getPrincipal());
        return "project/newproject";
    }

    @RequestMapping(value = {"/edit-project-{projectId}"}, method = RequestMethod.POST)
    public String updateUser(@Valid @ModelAttribute("project") Project project, BindingResult result,
                             ModelMap model) {
        if (result.hasErrors()) {
            return "project/newproject";
        }
        projectDao.update(project);
        model.addAttribute("successproject", "Project " + project.getProjectName() + " update successfully");
        return "project/projectsuccess";
    }

    @RequestMapping(value = {"/add-user-{projectId}"}, method = RequestMethod.GET)
    public String newUserInProject(ModelMap model) {
        Employee employee = new Employee();
        model.addAttribute("newuserinproject", employee);
        model.addAttribute("edit", false);
        model.addAttribute("loggedinuser", getPrincipal());
        return "project/addusertoproject";
    }

    @RequestMapping(value = {"/add-user-{projectId}"}, method = RequestMethod.POST)
    public String newUserInProject(@Valid @ModelAttribute("newuserinproject") Employee employee, BindingResult result,
                                   ModelMap model) {
        projectDao.insertUser(employee);
        model.addAttribute("successwhenaddingusertoproject", "User adding successfully");

        return "project/successwhenaddingusertoproject";
    }

    @RequestMapping(value = {"/get-all-user-{projectId}"}, method = RequestMethod.GET)
    public String getAllUserIntoProject(@PathVariable int projectId, ModelMap model) {
        List<Employee>  employee= projectDao.findAllEmployeeIntoProject(projectId);
        model.addAttribute("getAllUserIntoProject", employee);
        model.addAttribute("edit", false);
        model.addAttribute("loggedinuser", getPrincipal());
        return "project/alluserintoproject";
    }


    @ModelAttribute("objects")
    public List<Employee> findNameToAllObjects() {
        return projectDao.findAllObject();
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
}
