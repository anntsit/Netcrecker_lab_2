package edu.netcrecker.dao.impl;

import edu.netcrecker.model.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class UserDao {
    private JdbcTemplate jdbcTemplate;


    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Employee getUserInfo(String username) {
        String sql = "select ud.login, ud.password, up.type\n" +
                "from user_datails ud\n" +
                "inner join user_profilee up on up.id = ud.type_id\n" +
                "where ud.login =?";

        Employee userInfo = (Employee) jdbcTemplate.queryForObject(sql, new Object[]{username},
                new RowMapper<Employee>() {
                    public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Employee user = new Employee();
                        user.setLogin(rs.getString("login"));
                        user.setPassword(rs.getString("password"));
                        user.setRole(rs.getString("type"));
                        return user;
                    }
                });

        System.out.println("user ----" + userInfo);
        return userInfo;
    }

}
