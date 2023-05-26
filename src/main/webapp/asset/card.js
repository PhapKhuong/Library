var delCardModal = document.getElementById("delCardModal");
delCardModal.addEventListener("show.bs.modal", function (event) {

    var button = event.relatedTarget;

    var delCardId = button.getAttribute("data-bs-cardId");

    var modalBodyInputCardId = delCardModal.querySelector("#delCardId");

    modalBodyInputCardId.value = delCardId;
});