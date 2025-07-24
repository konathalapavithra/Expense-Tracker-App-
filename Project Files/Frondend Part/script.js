
let chart; // Chart.js instance

// Fetch and display expenses
async function loadExpenses() {
  try {
    const res = await fetch("http://localhost:8086/api/expenses");
    const data = await res.json();

    const monthFilter = document.getElementById("monthFilter");
    const selectedMonth = monthFilter ? monthFilter.value : "all";

    const filteredData = selectedMonth === "all"
      ? data
      : data.filter(exp => exp.date.slice(5, 7) === selectedMonth);

    const tbody = document.querySelector("#expenseTable tbody");
    if (tbody) {
      tbody.innerHTML = "";
      filteredData.forEach((expense) => {
        const row = `
          <tr>
            <td>${expense.id}</td>
            <td><input value="${expense.title}" data-id="${expense.id}" data-field="title" /></td>
            <td><input value="${expense.amount}" data-id="${expense.id}" data-field="amount" /></td>
            <td><input type="date" value="${expense.date}" data-id="${expense.id}" data-field="date" /></td>
            <td class="actions">
              <button class="edit" onclick="updateExpense(${expense.id})">Update</button>
              <button class="delete" onclick="deleteExpense(${expense.id})">Delete</button>
            </td>
          </tr>`;
        tbody.innerHTML += row;
      });
    }

    renderChart(filteredData); // 🌈 draw chart with filtered expenses
  } catch (error) {
    console.error("Error loading expenses:", error);
    alert("Failed to fetch expenses.");
  }
}

// Add new expense
const form = document.getElementById("expenseForm");
if (form) {
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const title = document.getElementById("title").value;
    const amount = document.getElementById("amount").value;
    const date = document.getElementById("date").value;

    try {
      await fetch("http://localhost:8086/api/expenses", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ title, amount, date })
      });

      form.reset();
      alert("Expense Added!");
      loadExpenses();
    } catch (error) {
      console.error("Add failed:", error);
      alert("Could not add expense.");
    }
  });
}

// Delete expense
async function deleteExpense(id) {
  try {
    await fetch(`http://localhost:8086/api/expenses/${id}`, {
      method: "DELETE",
    });
    loadExpenses();
  } catch (error) {
    console.error("Delete failed:", error);
    alert("Could not delete expense.");
  }
}

// Update expense
async function updateExpense(id) {
  try {
    const inputs = document.querySelectorAll(`input[data-id='${id}']`);
    const updatedExpense = {};
    inputs.forEach(input => {
      updatedExpense[input.dataset.field] = input.value;
    });

    await fetch(`http://localhost:8086/api/expenses/${id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(updatedExpense),
    });

    alert("Expense Updated!");
    loadExpenses();
  } catch (error) {
    console.error("Update failed:", error);
    alert("Could not update expense.");
  }
}

// Chart visualization with colorful bars
function renderChart(data) {
  const ctx = document.getElementById("expenseChart").getContext("2d");
  const labels = data.map(exp => exp.title);
  const values = data.map(exp => parseFloat(exp.amount));

  const backgroundColors = values.map(() => {
    const hue = Math.floor(Math.random() * 360);
    return `hsl(${hue}, 70%, 75%)`;
  });

  if (chart) chart.destroy();

  chart = new Chart(ctx, {
    type: "bar",
    data: {
      labels: labels,
      datasets: [{
        label: "₹ Expenses",
        data: values,
        backgroundColor: backgroundColors,
        borderColor: "#333",
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      plugins: {
        tooltip: {
          backgroundColor: "#222",
          titleColor: "#fff",
          bodyColor: "#f1f1f1",
          padding: 10,
          cornerRadius: 4
        }
      },
      scales: {
        x: {
          ticks: {
            color: "#333",
            font: { weight: "bold" }
          }
        },
        y: {
          beginAtZero: true,
          ticks: { color: "#333" },
          title: {
            display: true,
            text: "Amount Spent (₹)",
            color: "#333",
            font: { weight: "bold" }
          }
        }
      }
    }
  });
}

// Listen to month filter dropdown change
const monthDropdown = document.getElementById("monthFilter");
if (monthDropdown) {
  monthDropdown.addEventListener("change", () => {
    loadExpenses();
  });
}

// Load expenses on view-expenses page
if (window.location.pathname.includes("view-expenses.html")) {
  loadExpenses();
}