# 💰 Expense Tracker App

The Expense Tracker App is a Java-based full-stack project that helps users manage and track their daily expenses. It provides options to add, view, edit, and delete expenses, along with simple visual insights for better financial awareness.

## 🚀 Features

➕ Add Expenses – Record expenses with details like amount, date, and description.
📊 View Expenses – Display all expenses in a clear tabular format.
📝 Edit & Delete – Update or remove transactions as needed.
📈 Expense Summary – Get total calculation and simple charts for expense overview.

## 🛠️ Tech Stack
### Frontend

HTML5, CSS3, JavaScript
Responsive design with tables and charts

### Backend

Java, Spring Boot
REST APIs for CRUD operations
Controller, Service, Repository layered architecture

### Database

MySQL
Entities: Entities: User, Category, Transaction, Budget, Reminder

# 📂 Project Structure

ExpenseTrackerApp/

│── backend/

│   ├── src/main/java/com/expensetracker/

│   │   ├── controller/

│   │   ├── model/

│   │   ├── repository/

│   │   ├── service/

│   │   └── ExpenseTrackerApplication.java

│   └── src/main/resources/

│       ├── application.properties

│
│── frontend/

│   ├── index.html

│   ├── add-expense.html

│   ├── view-expenses.html

│   ├── style.css

│   └── script.js
│
│── README.md


## ⚙️ Installation & Setup
1. Clone the Repository
git clone https://github.com/your-username/expense-tracker-app.git
cd expense-tracker-app

2. Backend Setup (Spring Boot)

Open the backend project in Eclipse/IntelliJ.

Configure MySQL in application.properties:

spring.datasource.url=jdbc:mysql://localhost:3306/expense_tracker
spring.datasource.username=root
spring.datasource.password=yourpassword
spring.jpa.hibernate.ddl-auto=update
server.port=8082


Run the backend with:

mvn spring-boot:run

3. Frontend Setup

Open frontend/ folder in your browser or use a live server.

The frontend connects to backend APIs running on port 8082.

## 🔗 API Endpoints

Method	Endpoint	Description

POST	/api/transactions	Add new expense

GET	/api/transactions	View all expenses

PUT	/api/transactions/{id}	Edit expense

DELETE	/api/transactions/{id}	Delete expense

## 📊 Screenshots




