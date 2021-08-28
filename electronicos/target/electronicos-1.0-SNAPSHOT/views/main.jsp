<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<html>

<head>
    <link rel="stylesheet" href="${context}/assets/css/bootstrap.css">
    <title>Aparatos electrónicos</title>
    <style>
        .feather {
            width: 16px;
            height: 16px;
            stroke: currentColor;
            stroke-width: 2;
            stroke-linecap: round;
            stroke-linejoin: round;
            fill: none;
        }
    </style>
</head>

<body>
    <div class="container mt-5">
        <h5 class="">Aparatos electrónicos</h5>
        <table class="table">
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Dirección del fabricante</th>
                    <th>Fecha de registro</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody id="contenido">

            </tbody>
        </table>
        <button class="btn btn-success" onclick="showCreate()">
            <svg class="feather">
                <use xlink:href="${context}/assets/feather-sprite.svg#plus" />
                <span> Agregar aparato</span>
            </svg>
        </button>
    </div>

    <div class="modal fade" id="createModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-fade">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Nuevo aparato electrónico</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row gy-3">
                        <div class="col-md-4">
                            <label class="form-label">Nombre:</label>
                            <input type="text" class="form-control" name="name" id="nameInput">
                        </div>
                        <div class="col-md-8">
                            <label class="form-label">Direción del fabricante:</label>
                            <select name="address" id="addressInput" class="form-select" onchange="checkAddress()"></select>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="createDevice()" data-bs-dismiss="modal">Registrar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-fade">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Eliminar</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="${context}/Servlet" id="deleteForm" method="POST">
                        <input type="hidden" name="action" value="deleteDevice">
                        <input type="hidden" name="id" id="deleteId">
                    </form>
                    ¿Deseas eliminar "<span id="deleteName"></span>"?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" form="deleteForm" class="btn btn-danger">Eliminar</button>
                </div>
            </div>
        </div>
    </div>

    <input type="hidden" id="context" value="${context}">
    <script src="${context}/assets/js/bootstrap.bundle.js"></script>
    <script src="${context}/assets/js/jquery-3.6.0.js"></script>
    <script src="${context}/assets/js/main.js"></script>
</body>

</html>