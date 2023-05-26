<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: phapk
  Date: 25-May-23
  Time: 12:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Borrow</title>
    <link rel="stylesheet" href="/asset/style.css">
    <link rel="stylesheet" href="/asset/bootstrap.min.css">
</head>
<body>
<div class="container" id="wrapper">
    <form action="/library" method="post">
        <h2>Mượn sách</h2>
        <div id="popup">
            <c:if test="${error!=null}">
                <h3>${error}</h3>
            </c:if>
        </div>
        <table class="table">
            <tbody>
            <input type="hidden" name="action" value="borrow">
            <tr class="col">
                <td>Mã mượn sách</td>
                <td>
                    <input type="text" name="cardId" value="${initCardId}" required/>
                </td>
            </tr>
            <tr class="col">
                <td>Tên sách</td>

                <td>
                    <input type="hidden" name="borrowBookId" value="${book.bookId}"/>
                    <input type="text" name="borrowBookName" value="${book.bookName}"/>
                    <input type="hidden" name="borrowAuthor" value="${book.author}"/>
                    <input type="hidden" name="borrowDescription" value="${book.description}"/>
                    <input type="hidden" name="borrowQuantity" value="${book.quantity}"/>
                </td>
            </tr>
            <tr class="col">
                <td>Tên sinh viên</td>
                <td>
                    <select name="borrowStuId">
                        <option>Chọn tên sinh viên</option>
                        <c:forEach items="${students}" var="stu">
                            <option value="${stu.stuId}">${stu.stuName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr class="col">
                <td>Ngày mượn sách</td>
                <td>
                    <input type="date" name="loanDate" value="${initLoanDate}" required>
                </td>
            </tr>
            <tr class="col">
                <td>Ngày trả sách</td>
                <td>
                    <input type="date" name="returnDate" required>
                </td>
            </tr>
            </tbody>
        </table>
        <div>
            <a href="/library" class="btn btn-secondary">Cancel</a>
            <input type="submit" class="btn btn-secondary" value="OK">
        </div>
    </form>
</div>
</body>
<script src="/asset/bootstrap.bundle.min.js"></script>
<script src="/asset/book.js"></script>
</html>