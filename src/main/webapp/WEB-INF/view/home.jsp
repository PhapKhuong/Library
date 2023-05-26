<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: phapk
  Date: 24-May-23
  Time: 2:01 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="/asset/style.css">
    <link rel="stylesheet" href="/asset/bootstrap.min.css">
</head>
<body>
<div class="container" id="wrapper">
    <div id="main-content">
        <div id="menu">
            <!--TẠO NÚT HIỂN THỊ BOOK-->
            <a href="/library?action=book" class="btn btn-primary">
                Book
            </a>

            <!--TẠO NÚT HIỂN THỊ STUDENT-->
            <a href="/library?action=student" class="btn btn-primary">
                Student
            </a>

            <!--TẠO NÚT HIỂN THỊ CARD-->
            <a href="/library?action=card" class="btn btn-primary">
                Card
            </a>
        </div>


        <!--BOOK-->
        <c:if test="${select==1}">
            <div>
                <h2>Danh sách sách</h2>
                <table class="table">
                    <thread>
                        <tr>
                            <th scope="col">Mã sách</th>
                            <th scope="col">Tên sách</th>
                            <th scope="col">Tác giả</th>
                            <th scope="col">Mô tả</th>
                            <th scope="col">Số lượng</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                    </thread>
                    <tbody>
                    <c:forEach items="${books}" var="book">
                        <tr class="col">
                            <td>${book.bookId}</td>
                            <td>${book.bookName}</td>
                            <td>${book.author}</td>
                            <td>${book.description}</td>
                            <td>${book.quantity}</td>
                            <td>
                                <form action="/library" method="post">
                                    <input type="hidden" name="action" value="initBorrow">
                                    <input type="hidden" name="initBookId" value="${book.bookId}">
                                    <input type="hidden" name="initBookName" value="${book.bookName}">
                                    <input type="hidden" name="initAuthor" value="${book.author}">
                                    <input type="hidden" name="initDescription" value="${book.description}">
                                    <input type="hidden" name="initQuantity" value="${book.quantity}">
                                    <input type="submit" class="btn btn-primary" value="Borrow">
                                </form>
                            </td>
                            <td>
                                <button
                                        type="button"
                                        class="btn btn-primary"
                                        data-bs-toggle="modal"
                                        data-bs-target="#editBookModal"
                                        data-bs-bookId="${book.bookId}"
                                        data-bs-bookName="${book.bookName}"
                                        data-bs-author="${book.author}"
                                        data-bs-description="${book.description}"
                                        data-bs-quantity="${book.quantity}">
                                    Edit
                                </button>
                            </td>
                            <td>
                                <button
                                        type="button"
                                        class="btn btn-primary"
                                        data-bs-toggle="modal"
                                        data-bs-target="#delBookModal"
                                        data-bs-bookId="${book.bookId}">
                                    Del
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!--TẠO MODAL SỬA THÔNG TIN SÁCH-->
                <div class="modal fade"
                     id="editBookModal"
                     tabindex="-1"
                     aria-labelledby="editBookModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editBookModalLabel">Sửa thông tin</h5>
                                <button type="button"
                                        class="btn-close"
                                        data-bs-dismiss="modal"
                                        aria-label="Close">
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="/library" method="post">
                                    <input type="hidden" name="action" value="editBook">
                                    <div class="mb-3">
                                        <input type="hidden" class="form-control" id="bookId" name="bookId"/>
                                    </div>
                                    <div class="mb-3">
                                        <label for="bookName" class="col-form-label">Tên sách:</label>
                                        <input type="text" class="form-control" id="bookName" name="newBookName"
                                               required/>
                                    </div>
                                    <div class="mb-3">
                                        <label for="author" class="col-form-label">Tác giả:</label>
                                        <input type="text" class="form-control" id="author" name="newAuthor"
                                               required/>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="col-form-label">Mô tả:</label>
                                        <input type="text" class="form-control" id="description"
                                               name="newDescription" required/>
                                    </div>
                                    <div class="mb-3">
                                        <label for="quantity" class="col-form-label">Số lượng:</label>
                                        <input type="number" class="form-control" id="quantity" name="newQuantity"
                                               required/>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                            Close
                                        </button>
                                        <input type="submit" class="btn btn-secondary" value="OK">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!--TẠO MODAL XÓA SÁCH-->
                <div class="modal fade"
                     id="delBookModal"
                     tabindex="-1"
                     aria-labelledby="delBookModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="delBookModalLabel">Bạn có chắc chắn muốn xóa sách
                                    này?</h5>
                                <button type="button"
                                        class="btn-close"
                                        data-bs-dismiss="modal"
                                        aria-label="Close">
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="/library" method="post">
                                    <input type="hidden" name="action" value="delBook">
                                    <div class="mb-3">
                                        <input type="hidden" class="form-control" id="delBookId" name="delBookId"/>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                            Close
                                        </button>
                                        <input type="submit" class="btn btn-secondary" value="OK">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>


        <!--STUDENT-->
        <c:if test="${select==2}">
            <div>
                <h2>Danh sách sinh viên</h2>
                <table class="table">
                    <thread>
                        <tr>
                            <th scope="col">Mã sinh viên</th>
                            <th scope="col">Tên sinh viên</th>
                            <th scope="col">Lớp</th>
                        </tr>
                    </thread>
                    <tbody>
                    <c:forEach items="${students}" var="student">
                        <tr class="col">
                            <td>${student.stuId}</td>
                            <td>${student.stuName}</td>
                            <td>${student.grade}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>


        <!--CARD-->
        <c:if test="${select==3}">
            <div>
                <h2>Danh sách thẻ mượn sách</h2>
                <table class="table">
                    <thread>
                        <tr>
                            <th scope="col">Mã thẻ</th>
                            <th scope="col">Tên sách</th>
                            <th scope="col">Tác giả</th>
                            <th scope="col">Tên sinh viên</th>
                            <th scope="col">Lớp</th>
                            <th scope="col">Ngày mượn</th>
                            <th scope="col">Ngày trả</th>
                            <th scope="col"></th>
                        </tr>
                    </thread>
                    <tbody>
                    <c:forEach items="${cards}" var="card">
                        <tr class="col">
                            <td>${card.cardId}</td>
                            <td>${card.book.getBookName()}</td>
                            <td>${card.book.getAuthor()}</td>
                            <td>${card.student.getStuName()}</td>
                            <td>${card.student.getGrade()}</td>
                            <td>
                                <fmt:parseDate value="${card.loanDate}" pattern="yyyy-MM-dd" type="date"
                                               var="loanDateFormat"/>
                                <fmt:formatDate value="${loanDateFormat}" pattern="dd/MM/yyyy"/>
                            </td>
                            <td>
                                <fmt:parseDate value="${card.returnDate}" pattern="yyyy-MM-dd" type="date"
                                               var="returnDateFormat"/>
                                <fmt:formatDate value="${returnDateFormat}" pattern="dd/MM/yyyy"/>
                            </td>
                            <td>
                                <c:if test="${card.status == false}">
                                    <button
                                            type="button"
                                            class="btn btn-primary"
                                            disabled>
                                        Trả sách
                                    </button>
                                </c:if>
                                <c:if test="${card.status ==true}">
                                    <button
                                            type="button"
                                            class="btn btn-primary"
                                            data-bs-toggle="modal"
                                            data-bs-target="#delCardModal"
                                            data-bs-cardId="${card.cardId}">
                                        Trả sách
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!--TẠO MODAL TRẢ SÁCH-->
                <div class="modal fade"
                     id="delCardModal"
                     tabindex="-1"
                     aria-labelledby="delCardModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="delCardModalLabel">Trả sách</h5>
                                <button type="button"
                                        class="btn-close"
                                        data-bs-dismiss="modal"
                                        aria-label="Close">
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="/library" method="post">
                                    <input type="hidden" name="action" value="delCard">
                                    <div class="mb-3">
                                        <input type="hidden" class="form-control" id="delCardId" name="delCardId"/>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                                data-bs-dismiss="modal">
                                            Close
                                        </button>
                                        <input type="submit" class="btn btn-secondary" value="OK">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>
</body>
<script src="/asset/bootstrap.bundle.min.js"></script>
<script src="/asset/book.js"></script>
<script src="/asset/card.js"></script>
</html>
