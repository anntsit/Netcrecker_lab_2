package edu.netcrecker.dao.impl;

import edu.netcrecker.dao.EmployeeDao;
import edu.netcrecker.model.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

public class EmployeeDaoImpl implements EmployeeDao {
    @Autowired
    private PasswordEncoder passwordEncoder;

    private JdbcTemplate jdbcTemplate;

    public EmployeeDaoImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }


    @Override
    public void Update(Employee employee) {
        if (employee.getObjectId() > 0) {
            String sqlObject = "Update objects set object_id=?,object=?,object_type_id=? where object_id=?";
            jdbcTemplate.update(sqlObject, employee.getObjectId(), employee.getObject(), employee.getoType(), employee.getObjectId());

            String sqlAttributes = "Update attributes set attr_id = ?, attr_name=?, object_type_id=? where attr_id=?";
            jdbcTemplate.update(sqlAttributes, employee.getAttrId(), employee.getAttrName(), employee.getoType(), employee.getAttrId());

            String sqlParams = "Update params set empno=?,mgr=?,hirerdate =?,sal =?,com=?,deptno=? where object_id=?";
            jdbcTemplate.update(sqlParams, employee.getEmpno(), employee.getMgr(), parseTime(employee.getHirerDate()), employee.getSal(),
                    employee.getCom(), employee.getDeptno(), employee.getObjectId());


            String sqlLogin = "Update user_datails set login =? , password =? , type_id=? where object_id=?";
            employee.setPassword(passwordEncoder.encode(employee.getPassword()));
            jdbcTemplate.update(sqlLogin, employee.getLogin(), employee.getPassword(), employee.getRole(), employee.getObjectId());
        }
    }

    @Override
    public void delete(int employeeId) {
        String sql = "Delete from objects,params,attributes \n" +
                "USING objects inner join params inner join attributes\n" +
                "where objects.object_id = params.object_id \n" +
                "AND params.attr_id = attributes.attr_id AND objects.object_id =?";
        jdbcTemplate.update(sql, employeeId);

    }

    @Override
    public Employee getEmployee(int employeeId) {
        String sql = "select o.object_id,o.object,o.object_type_id,att.attr_id,att.attr_name,\n" +
                "p.empno,p.mgr,p.hirerdate,p.sal,p.com,p.deptno,\n" +
                "ud.login,ud.password,ud.type_id\n" +
                "from objects o\n" +
                "inner join user_datails ud on ud.object_id = o.object_id\n" +
                "inner join params p  on p.object_id = ud.object_id\n" +
                "inner join attributes att on att.attr_id = p.attr_id\n" +
                "where o.object_id=" + employeeId;
        return jdbcTemplate.query(sql, new ResultSetExtractor<Employee>() {

            @Override
            public Employee extractData(ResultSet rs) throws SQLException,
                    DataAccessException {
                if (rs.next()) {
                    Employee employee = new Employee();
                    employee.setObjectId(rs.getInt("object_id"));
                    employee.setObject(rs.getString("object"));
                    employee.setoType(rs.getString("object_type_id"));
                    employee.setAttrId(rs.getInt("attr_id"));
                    employee.setAttrName(rs.getString("attr_name"));
                    employee.setEmpno(rs.getInt("empno"));
                    employee.setMgr(rs.getInt("mgr"));
                    employee.setHirerDate(rs.getString("hirerdate"));
                    employee.setSal(rs.getFloat("sal"));
                    employee.setCom(rs.getFloat("com"));
                    employee.setDeptno(rs.getInt("deptno"));
                    employee.setLogin(rs.getString("login"));
//                    employee.setPassword(passwordEncoder.encode(rs.getString("password")));
                    employee.setPassword(rs.getString("password"));
                    employee.setRole(rs.getString("type_id"));
                    return employee;
                }
                return null;
            }

        });
    }

    @Override
    public List<Employee> list() {
        String sql = "select o.object_id, o.object,\n" +
                "ot.o_type,\n" +
                "attr.attr_name,\n" +
                "p.empno,p.mgr,p.hirerdate,p.sal,p.com,p.deptno,c.name\n" +
                "from  objects o, object_types ot, attributes attr, params p,city c\n" +
                "where o.object_id = p.object_id and p.attr_id = attr.attr_id\n" +
                "and p.deptno = c.id\n" +
                "and o.object_type_id = ot.object_type_id";
        List<Employee> listEmployee = jdbcTemplate.query(sql, new RowMapper<Employee>() {

            @Override
            public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
                Employee employee = new Employee();

                employee.setObjectId(rs.getInt("object_id"));
                employee.setObject(rs.getString("object"));
                employee.setoType(rs.getString("o_type"));
                employee.setAttrName(rs.getString("attr_name"));
                employee.setEmpno(rs.getInt("empno"));
                employee.setMgr(rs.getInt("mgr"));
                employee.setHirerDate(rs.getString("hirerdate"));
                employee.setSal(rs.getFloat("sal"));
                employee.setCom(rs.getInt("com"));
                employee.setDeptno(rs.getInt("deptno"));
                employee.setCity(rs.getString("name"));
                return employee;
            }

        });

        return listEmployee;
    }

    @Override
    public void insertEmplyee(Employee employee) {
        String sql1 = "Insert into objects(object_id,object,object_type_id)\n" +
                "values(?,?,?)";
        jdbcTemplate.update(sql1, employee.getObjectId(), employee.getObject(), employee.getoType());

        String sql2 = "insert into attributes(attr_id,attr_name,object_type_id)\n" +
                "values(?,?,?)";
        jdbcTemplate.update(sql2, employee.getAttrId(), employee.getAttrName(), employee.getoType());

        String sql3 = "insert into params(empno,mgr,hirerdate,sal,com,deptno,attr_id,object_id)\n" +
                "values(?,?,?,?,?,?,?,?)";
        jdbcTemplate.update(sql3, employee.getEmpno(), employee.getMgr(), parseTime(employee.getHirerDate()),
                employee.getSal(), employee.getCom(), employee.getDeptno(), employee.getAttrId(),
                employee.getObjectId());

        String sql4 = "insert into user_datails(login,password,object_id,type_id)\n" +
                "values(?,?,?,?)";

        employee.setPassword(passwordEncoder.encode(employee.getPassword()));
        jdbcTemplate.update(sql4, employee.getLogin(), employee.getPassword(), employee.getObjectId(), employee.getRole());


    }

    private Timestamp parseTime(String str_date) {
        try {
            DateFormat formatter;
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date date = formatter.parse(str_date);
            Timestamp timestamp = new Timestamp(date.getTime());
            return timestamp;
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Employee> getAllCity() {
        String sql = "select id,name from city";
        List<Employee> listEmployee = jdbcTemplate.query(sql, new RowMapper<Employee>() {

            @Override
            public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
                Employee employee = new Employee();
                employee.setDeptno(rs.getInt("id"));
                employee.setCity(rs.getString("name"));
                return employee;
            }

        });
        return listEmployee;
    }

    @Override
    public List<Employee> getAllRoles() {
        String sql = "select id,type from user_profilee";
        List<Employee> listEmployee = jdbcTemplate.query(sql, new RowMapper<Employee>() {

            @Override
            public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
                Employee employee = new Employee();
                employee.setRolesId(rs.getInt("id"));
                employee.setRole(rs.getString("type"));
                return employee;
            }

        });
        return listEmployee;
    }
}
