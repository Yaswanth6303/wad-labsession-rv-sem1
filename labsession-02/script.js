const form = document.querySelector("form");
const tableBody = document.getElementById("tableBody");
const submitBtn = form.querySelector('button[type="submit"]');

let editingRow = null;

form.addEventListener("submit", function (e) {
  e.preventDefault();

  const name = document.getElementById("fname").value;
  const price = document.getElementById("product").value;
  const quantity = document.getElementById("price").value;

  if (editingRow) {
    // Update existing row
    editingRow.cells[0].textContent = name;
    editingRow.cells[1].textContent = price;
    editingRow.cells[2].textContent = quantity;
    editingRow = null;
    submitBtn.textContent = "Submit";
    submitBtn.classList.remove("btn-success");
    submitBtn.classList.add("btn-primary");
  } else {
    // Add new row
    const row = document.createElement("tr");
    row.innerHTML = `
            <td>${name}</td>
            <td>${price}</td>
            <td>${quantity}</td>
            <td>
                <button class="btn btn-warning btn-sm edit-btn">Edit</button>
                <button class="btn btn-danger btn-sm delete-btn">X</button>
            </td>
          `;
    tableBody.appendChild(row);
  }

  form.reset();
});

tableBody.addEventListener("click", function (e) {
  if (e.target.classList.contains("delete-btn")) {
    e.target.closest("tr").remove();
    // If we were editing this row, cancel the edit
    if (editingRow && !document.contains(editingRow)) {
      editingRow = null;
      submitBtn.textContent = "Submit";
      submitBtn.classList.remove("btn-success");
      submitBtn.classList.add("btn-primary");
      form.reset();
    }
  }

  if (e.target.classList.contains("edit-btn")) {
    const row = e.target.closest("tr");
    editingRow = row;

    // Populate form with row data
    document.getElementById("fname").value = row.cells[0].textContent;
    document.getElementById("product").value = row.cells[1].textContent;
    document.getElementById("price").value = row.cells[2].textContent;

    // Change submit button to indicate update mode
    submitBtn.textContent = "Update";
    submitBtn.classList.remove("btn-primary");
    submitBtn.classList.add("btn-success");
  }
});
