package com.repository.itf;

import com.bean.Book;

import java.util.List;

public interface BookRepository {
    List<Book> display();

    void update(Book book);

    void delete(int id);
}
