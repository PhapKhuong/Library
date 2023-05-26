package com.controller;

import com.bean.Book;
import com.bean.Card;
import com.bean.Student;
import com.service.impl.BookServiceImpl;
import com.service.impl.CardServiceImpl;
import com.service.impl.StudentServiceImpl;
import com.service.itf.BookService;
import com.service.itf.CardService;
import com.service.itf.StudentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "libraryServlet", value = "/library")
public class LibraryServlet extends HttpServlet {
    private BookService bookService = new BookServiceImpl();
    private StudentService studentService = new StudentServiceImpl();
    private CardService cardService = new CardServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "book";
        }

        switch (action) {
            case "book":
                showListBook(req, resp);
                break;
            case "student":
                showListStudent(req, resp);
                break;
            case "card":
                showListCard(req, resp);
                break;
            case "borrow":
                showBorrowForm(req, resp);
                break;
            default:
                showListBook(req, resp);
                break;
        }
    }

    private void showBorrowForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/view/borrow.jsp").forward(req, resp);
    }

    private void showListBook(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Book> books = bookService.display();
        int select = 1;
        req.setAttribute("select", select);
        req.setAttribute("books", books);
        req.getRequestDispatcher("WEB-INF/view/home.jsp").forward(req, resp);
    }

    private void showListStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Student> students = studentService.display();
        int select = 2;
        req.setAttribute("select", select);
        req.setAttribute("students", students);
        req.getRequestDispatcher("WEB-INF/view/home.jsp").forward(req, resp);
    }

    private void showListCard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Card> cards = cardService.display();
        int select = 3;
        req.setAttribute("select", select);
        req.setAttribute("cards", cards);
        req.getRequestDispatcher("WEB-INF/view/home.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        switch (action) {
            case "editBook":
                doEdit(req, resp);
                break;
            case "delBook":
                doDelBook(req, resp);
                break;
            case "initBorrow":
                doInitBorrow(req, resp);
                break;
            case "borrow":
                doBorrow(req, resp);
                break;
            case "delCard":
                doDelCard(req, resp);
                break;
            default:
                break;
        }
    }

    private void doEdit(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int bookId = Integer.parseInt(req.getParameter("bookId"));
        String newBookName = req.getParameter("newBookName");
        String newAuthor = req.getParameter("newAuthor");
        String newDescription = req.getParameter("newDescription");
        int newQuantity = Integer.parseInt(req.getParameter("newQuantity"));

        Book book = new Book(bookId, newBookName, newAuthor, newDescription, newQuantity);
        bookService.update(book);
        resp.sendRedirect("/library");
    }

    private void doDelBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int delBookId = Integer.parseInt(req.getParameter("delBookId"));

        bookService.delete(delBookId);
        resp.sendRedirect("/library");
    }

    private void doInitBorrow(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int initQuantity = Integer.parseInt(req.getParameter("initQuantity"));
        if (initQuantity == 0) {
            String errorMsg = "Không còn sách này trong thư viện";
            req.setAttribute("error", errorMsg);
        } else {
            List<Card> cards = cardService.display();
            int maxCardId = 0;
            for (Card card : cards) {
                if (card.getCardId() >= maxCardId) {
                    maxCardId = card.getCardId();
                }
            }
            int initCardId = maxCardId + 1;

            int initBookId = Integer.parseInt(req.getParameter("initBookId"));
            String initBookName = req.getParameter("initBookName");
            String initAuthor = req.getParameter("initAuthor");
            String initDescription = req.getParameter("initDescription");
            Book book = new Book(initBookId, initBookName, initAuthor, initDescription, initQuantity);

            List<Student> students = studentService.display();

            LocalDate initLoanDate = LocalDate.now();

            req.setAttribute("initCardId", initCardId);
            req.setAttribute("book", book);
            req.setAttribute("students", students);
            req.setAttribute("initLoanDate", initLoanDate);
        }
        req.getRequestDispatcher("WEB-INF/view/borrow.jsp").forward(req, resp);
    }

    private void doBorrow(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int cardId = Integer.parseInt(req.getParameter("cardId"));

        int bookId = Integer.parseInt(req.getParameter("borrowBookId"));
        String bookName = req.getParameter("borrowBookName");
        String author = req.getParameter("borrowAuthor");
        String description = req.getParameter("borrowDescription");
        int quantity = Integer.parseInt(req.getParameter("borrowQuantity")) - 1;
        Book book = new Book(bookId, bookName, author, description, quantity);
        bookService.update(book);

        Student student = null;
        List<Student> students = studentService.display();
        int stuId = Integer.parseInt(req.getParameter("borrowStuId"));
        for (Student stu : students) {
            if (stu.getStuId() == stuId) {
                student = stu;
                break;
            }
        }

        LocalDate loanDate = LocalDate.parse(req.getParameter("loanDate"));
        LocalDate returnDate = LocalDate.parse(req.getParameter("returnDate"));

        Card card = new Card(cardId, book, student, true, loanDate, returnDate);
        cardService.create(card);
        resp.sendRedirect("/library");
    }

    private void doDelCard(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Card> cards = cardService.display();
        List<Book> books = bookService.display();

        int cardId = Integer.parseInt(req.getParameter("delCardId"));
        int bookId = 0;
        for (Card card : cards) {
            if (card.getCardId() == cardId) {
                bookId = card.getBook().getBookId();
                break;
            }
        }
        for (Book book : books) {
            if (book.getBookId() == bookId) {
                bookService.update(new Book(bookId, book.getBookName(), book.getAuthor(),
                        book.getDescription(), book.getQuantity() + 1));
                break;
            }
        }
        cardService.update(cardId);
        resp.sendRedirect("/library");
    }
}
