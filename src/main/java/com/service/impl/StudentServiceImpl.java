package com.service.impl;

import com.bean.Student;
import com.repository.impl.StudentRepositoryImpl;
import com.repository.itf.StudentRepository;
import com.service.itf.StudentService;

import java.util.List;

public class StudentServiceImpl implements StudentService {
    private StudentRepository repository = new StudentRepositoryImpl();

    @Override
    public List<Student> display() {
        return repository.display();
    }
}
