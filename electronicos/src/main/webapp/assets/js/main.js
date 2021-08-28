var createModal = new bootstrap.Modal(document.getElementById('createModal'), {});
var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'), {});
var context = document.getElementById("context").value;

function content() {
    $.ajax({
        type: 'POST',
        url: `${context}/Servlet`,
        data: {action:"getAllDevices"}
    }).done(function (res) {
        let actions;
        let status;
        document.getElementById("contenido").innerHTML = "";
        for (let device of res) {
            if (device.status == 1) {
                actions = `
                    <form action="${context}/Servlet" method="post" class="d-inline">
                        <input type="hidden" name="action" value="goToUpdate">
                        <input type="hidden" name="id" value="${device.id}">
                        <button class="btn btn-primary">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/feather-sprite.svg#edit"/>
                            </svg>
                        </button>
                    </form>
                    <button class="btn btn-danger" onclick="showDelete('${device.id}','${device.name}')">
                        <svg class="feather">
                            <use xlink:href="${context}/assets/feather-sprite.svg#trash-2"/>
                        </svg>
                    </button>
                `;
                status = `<span class="badge bg-success">Activo</span>`;
            } else {
                actions = "";
                status = `<span class="badge bg-secondary">Inactivo</span>`;
            }
            document.getElementById("contenido").innerHTML += `
                <tr>
                    <td>${device.name}</td>
                    <td>Calle ${device.address.street}, Col. ${device.address.town}, C.P. ${device.address.zipCode}, ${device.address.state}, ${device.address.country}</td>
                    <td>${device.registerDate}</td>
                    <td>
                        ${status}
                    </td>
                    <td>
                        ${actions}
                    </td>
                </tr>
            `;
        }
    });
}

function checkAddress () {
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

function createDevice() {
    $.ajax({
        type: 'POST',
        url: `${context}/Servlet`,
        data: {
            action:"createDevice",
            name:document.getElementById("nameInput").value,
            address:document.getElementById("addressInput").value,
            street:document.getElementById("streetInput").value,
            town:document.getElementById("townInput").value,
            zipCode:document.getElementById("zipCodeInput").value,
            state:document.getElementById("stateInput").value,
            country:document.getElementById("countryInput").value
        }
    }).done(function () {
        content();
        createModal.hide();
    });
}

function showCreate() {
    $.ajax({
        type: 'POST',
        url: `${context}/Servlet`,
        data: { action: "getAllAddresses" }
    }).done(function (res) {
        document.getElementById("addressInput").innerHTML = '<option selected value="">Seleccione una opción...</option>';
        for (let address of res) {
            document.getElementById("addressInput").innerHTML += `<option value="${address.id}">Calle ${address.street}, Col. ${address.town}, C.P. ${address.zipCode}, ${address.state}, ${address.country}</option>`;
        }
        document.getElementById("addressInput").innerHTML += '<option value="0">Nueva dirección</option>';

        document.getElementById("nameInput").value = "";
        document.getElementById("streetInput").value = "";
        document.getElementById("townInput").value = "";
        document.getElementById("zipCodeInput").value = "";
        document.getElementById("stateInput").value = "";
        document.getElementById("countryInput").value = "";
        checkAddress();

        createModal.show();
    });
}

function showDelete(id, name) {
    document.getElementById("deleteId").value = id;
    document.getElementById("deleteName").innerHTML = name;
    deleteModal.show();
}

content();
checkAddress();