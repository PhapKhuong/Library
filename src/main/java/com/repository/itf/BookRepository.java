package com.repository.itf;

import com.bean.Book;
import com.bean.Student;

import java.util.List;

public interface BookRepository {
    List<Book> display();

    void update(Book book);

    void delete(int id);

    void create (Book book);

    List<Book> searchByName(String str);
}
