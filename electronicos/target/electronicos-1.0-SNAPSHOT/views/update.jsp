<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <link rel="stylesheet" href="${context}/assets/css/bootstrap.css">
    <title>Aparatos electrónicos</title>
</head>
<body>
    <div class="container mt-5">
        <h5>Actualizar datos del aparato electrónico</h5>
        <form action="${context}/Servlet" class="m-3" id="updateForm" method="POST">
            <input type="hidden" name="action" value="updateDevice">
            <input type="hidden" name="id" value="${device.id}">
            <div class="row gy-3">
                <div class="col-md-4">
                    <label class="form-label">Nombre:</label>
                    <input type="text" class="form-control" name="name" id="nameInput" value="${device.name}">
                </div>
                <div class="col-md-8">
                    <label class="form-label">Direción del fabricante:</label>
                    <select name="address" id="addressInput" class="form-select" onchange="checkAddress()">
                        <option value="">Seleccione una opción...</option>
                        <c:forEach items="${addresses}" var="address">
                            <c:choose>
                                <c:when test="${device.address.id == address.id}">
                                    <option value="${address.id}" selected>Calle ${address.street}, Col. ${address.town}, C.P. ${address.zipCode}, ${address.state}, ${address.country}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${address.id}">Calle ${address.street}, Col. ${address.town}, C.P. ${address.zipCode}, ${address.state}, ${address.country}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <option value="0">Nueva dirección</option>
                    </select>
                </div>
                <div class="col-md-4 addressContainer">
                    <label class="form-label">Calle:</label>
                    <input type="text" class="form-control" name="street" id="streetInput">
                </div>
                <div class="col-md-4 addressContainer">
                    <label class="form-label">Colonia:</label>
                    <input type="text" class="form-control" name="town" id="townInput">
                </div>
                <div class="col-md-4 addressContainer">
                    <label class="form-label">Código postal:</label>
                    <input type="number" class="form-control" name="zipCode" id="zipCodeInput">
                </div>
                <div class="col-md-4 addressContainer">
                    <label class="form-label">Estado:</label>
                    <input type="text" class="form-control" name="state" id="stateInput">
                </div>
                <div class="col-md-4 addressContainer">
                    <label class="form-label">País:</label>
                    <input type="text" class="form-control" name="country" id="countryInput">
                </div>
            </div>
        </form>
        <a href="${context}/Servlet" class="btn btn-secondary">Cancelar</a>
        <button type="submit" class="btn btn-primary" form="updateForm">Guardar cambios</button>
    </div>

    <script src="${context}/assets/js/bootstrap.bundle.js"></script>
    <script>
        function checkAddress() {
            let collection = document.getElementsByClassName("addressContainer");
            if (document.getElementById("addressInput").value == "0") {
                for (let container of collection) {
                    container.style.display = "initial";
                }
            } else {
                for (let container of collection) {
                    container.style.display = "none";
                }
            }
        }
        checkAddress();
    </script>
</body>
</html>
