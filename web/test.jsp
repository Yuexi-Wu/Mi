<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/20
  Time: 下午2:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="getAllProducts.action" method="post" accept-charset="UTF-8">
        <input type="submit" value="submit">
        <c:forEach items="${list}" var="p">
            <p>${p.productId}</p>
            <p>${p.productName}</p>
            <p>${p.productIntro}</p>
            <p>${p.productColor}</p>
            <p>${p.productVersion}</p>
            <p>${p.productPrice}</p>
            <p>${p.productSales}</p>
            <p>${p.productTime}</p>
            <p>${p.productMax}</p>
            <c:forEach items="${p.comments}" var="c">
                <p>${c.content}</p>
                <p>${c.totalLevel}</p>
            </c:forEach>
        </c:forEach>
    </form>
</body>
</html>
