package com.repository.impl;

import com.bean.Student;
import com.database.DBConnection;
import com.database.MyQuery;
import com.repository.itf.StudentRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentRepositoryImpl implements StudentRepository {
    @Override
    public List<Student> display() {
        Connection connection = DBConnection.getConnection();
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Student> studentList = new ArrayList<>();

        if (connection != null) {
            try {
                statement = connection.prepareStatement(MyQuery.SELECT_ALL_STUDENT);
                resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    int stuId = resultSet.getInt("stuId");
                    String stuName = resultSet.getString("stuName");
                    String grade = resultSet.getString("grade");

                    studentList.add(new Student(stuId, stuName, grade));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    statement.close();
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                DBConnection.close();
            }
        }
        return studentList;
    }
}
