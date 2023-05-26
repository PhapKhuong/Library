package com.service.itf;

import com.bean.Book;

import java.util.List;

public interface BookService {
    List<Book> display();

    void update(Book book);

    void delete (int id);
}
