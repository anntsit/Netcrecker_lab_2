package edu.netcrecker.model;

import org.hibernate.validator.constraints.NotEmpty;


import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Employee {
    //for list all employes
    private int objectId;

    @Size(min = 3, max = 20)
    private String object;

    @NotEmpty
    private String oType;

    private int empno;

    @NotEmpty
    private String attrName;
    private int mgr;
    @NotEmpty
    private String hirerDate;
    private float sal;
    private float com;
    private int deptno;
    private String city;
    @NotEmpty
    private String login;
    @NotEmpty
    private String password;
    @NotEmpty
    private String role;
    private int attrId;
    private int rolesId;
    private int projectId;


    public int getAttrId() {
        return attrId;
    }

    public void setAttrId(int attrId) {
        this.attrId = attrId;
    }

    public int getObjectId() {
        return objectId;
    }

    public void setObjectId(int objectId) {
        this.objectId = objectId;
    }

    public String getObject() {
        return object;
    }

    public void setObject(String object) {
        this.object = object;
    }

    public String getoType() {
        return oType;
    }

    public void setoType(String oType) {
        this.oType = oType;
    }

    public String getAttrName() {
        return attrName;
    }

    public void setAttrName(String attrName) {
        this.attrName = attrName;
    }

    public int getMgr() {
        return mgr;
    }

    public void setMgr(int mgr) {
        this.mgr = mgr;
    }

    public String getHirerDate() {
        return hirerDate;
    }

    public void setHirerDate(String hirerDate) {
        this.hirerDate = hirerDate;
    }

    public float getSal() {
        return sal;
    }

    public void setSal(float sal) {
        this.sal = sal;
    }

    public float getCom() {
        return com;
    }

    public void setCom(float com) {
        this.com = com;
    }

    public int getDeptno() {
        return deptno;
    }

    public void setDeptno(int deptno) {
        this.deptno = deptno;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }


    public int getRolesId() {
        return rolesId;
    }

    public void setRolesId(int rolesId) {
        this.rolesId = rolesId;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public int getEmpno() {
        return empno;
    }

    public void setEmpno(int empno) {
        this.empno = empno;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Employee() {
    }

    @Override
    public String toString() {
        return "Employee{" +
                "objectId=" + objectId +
                ", object='" + object + '\'' +
                ", oType='" + oType + '\'' +
                ", attrName='" + attrName + '\'' +
                ", mgr=" + mgr +
                ", hirerDate='" + hirerDate + '\'' +
                ", sal=" + sal +
                ", com=" + com +
                ", deptno=" + deptno +
                ", login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", role='" + role + '\'' +
                ", attrId=" + attrId +
                '}';
    }
}
