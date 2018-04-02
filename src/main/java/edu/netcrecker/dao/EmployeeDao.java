package edu.netcrecker.dao;


import edu.netcrecker.model.Employee;


import java.util.List;

public interface EmployeeDao {
    void Update(Employee employee);

    void delete(int employeeId);

    Employee getEmployee(int employeeId);

    List<Employee> list();

    void insertEmplyee(Employee employee);

    List<Employee> getAllRoles();

    List<Employee> getAllCity();
}
