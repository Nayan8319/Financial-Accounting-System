# 💰 Financial Accounting System – Smart Business Accounting 💼

🌐 **Financial Accounting System** is a modern full-stack solution for efficient, secure, and scalable business financial management. Whether you're running a small firm or an enterprise 🏢, this system helps you handle products 📦, users 👥, customers 👨‍💼, and sales 💳 – all from one dashboard! 📊💻

> ⚡ **Built with Java (NetBeans) + MySQL + HTML/Bootstrap**

---

## 🚀 Project Highlights

✨ **End-to-End Financial Control** – Seamlessly manage users 👥, products 📦, sales 💳, and reports 🧾
🛡️ **Secure Authentication** – Role-based access 🔑 for Admin & Users
📦 **Real-Time Inventory** – Track stock 📊 and manage availability 🟢🔴
📤 **Instant Reports** – Export PDF summaries 📄 with one click 🖱️
🔍 **Smart Search** – Quickly locate 🔎 users/products by name, ID, or email

---

## 🎯 Key Objectives

* 📊 **Digitize Operations** – Say goodbye 👋 to manual accounting ledgers
* 💡 **Improve Accuracy** – Minimize entry errors ❌✔️ with validations and clean UI
* ⚙️ **Optimize Workflow** – Set roles & permissions 👨‍💼, control access, and streamline tasks
* 🔐 **Secure Access** – Only authorized users 🛂 can access sensitive financial data

---

## 🧩 Core Features

### 👤 User Features

* 🔐 Login with Validation
* 👥 View/Edit Profile
* 📦 Access Product Listings
* 📊 Sales Overview Dashboard
* 🧾 Export PDF Report
* 🔍 Smart Filter/Search

### 🛠️ Admin Features

* 👥 Add/Edit/Delete Users
* ✅ Set Roles & Permissions
* 📋 Product Inventory Management
* 📉 Activate/Deactivate Users
* 📄 Generate All Reports

---

## 🧪 Sample Test Cases

| ✅ Test          | 🎯 Input              | 📌 Expected Output         | 🧪 Status |
| --------------- | --------------------- | -------------------------- | --------- |
| Login           | Valid credentials     | Dashboard loads by role    | ✅ Passed  |
| Add Product     | All required fields   | Product added successfully | ✅ Passed  |
| Deactivate User | Admin clicks toggle   | User marked as inactive    | ✅ Passed  |
| Export Report   | Export button clicked | PDF downloaded             | ✅ Passed  |

---

## 🔧 Tech Stack

| 🏗️ Layer    | ⚙️ Technology          |
| ------------ | ---------------------- |
| 🎨 Front-End | HTML, Bootstrap 4/5    |
| 🔧 Back-End  | Java (NetBeans IDE 18) |
| 🗄️ Database | MySQL Workbench        |
| 🧰 Tools     | NetBeans, Web Browsers |
| 💻 OS        | Windows 10/11          |

---

## 🗃️ Database Schema – MySQL

### 🔐 `Login`

| 🧾 Column    | 🧠 Type | 🔐 Description              |
| ------------ | ------- | --------------------------- |
| `_id`        | Integer | 🔑 Unique ID for user/admin |
| `name`       | String  | 🧑‍💼 Name of user/admin    |
| `email`      | String  | 📧 Email ID                 |
| `isAdmin`    | Boolean | 👨‍💼 Admin or User flag    |
| `permission` | Array   | ✅ Permissions granted       |
| `status`     | String  | 🔴🟢 Active or Inactive     |

### 📦 `Product`

| 🧾 Column         | 🧠 Type | 🔐 Description                      |
| ----------------- | ------- | ----------------------------------- |
| `ObjectId`        | Integer | 🔑 Product ID                       |
| `name`            | String  | 📦 Product Name                     |
| `category`        | String  | 🗂️ Category of Product             |
| `price`           | Integer | 💰 Price of Product                 |
| `quantity`        | Integer | 🔢 Available Quantity               |
| `inventoryStatus` | String  | 📊 Stock Status (In/Out/Less Stock) |

---

## 📸 UI Snapshots

> 📂 Place these screenshots in the `/screenshots` folder of your GitHub repo for preview.

### 🔐 Login Page

![Login Page](https://github.com/Nayan8319/Financial-Accounting-System/blob/main/moduleImages/mainModules/Login.png)

### 📦 Admin Dashboard

![Product Inventory](https://github.com/Nayan8319/Financial-Accounting-System/blob/main/moduleImages/mainModules/adminDashboard.png)

### 👨‍💼 User Management

![Product Inventory](https://github.com/Nayan8319/Financial-Accounting-System/blob/main/moduleImages/mainModules/userManagement.png)

### 📦 Reports 

![Product Inventory](https://github.com/Nayan8319/Financial-Accounting-System/blob/main/moduleImages/mainModules/report.png)


### 📦 User Dashboard

![Cart](https://github.com/Nayan8319/Financial-Accounting-System/blob/main/moduleImages/mainModules/userDashboard.png)

### 👨‍💼 Customer Management

![Product Inventory](https://github.com/Nayan8319/Financial-Accounting-System/blob/main/moduleImages/mainModules/customerManagement.png)

### 👨‍💼 Products Management

![Product Inventory](https://github.com/Nayan8319/Financial-Accounting-System/blob/main/moduleImages/mainModules/productManagement.png)

### 👨‍💼 Sales Management

![Product Inventory](https://github.com/Nayan8319/Financial-Accounting-System/blob/main/moduleImages/mainModules/saleManagement.png)

---

## 📱 Future Enhancements

🧠 AI-Based Financial Insights
📱 Mobile App Interface
💬 Multi-User Collaboration
📈 Profit Analytics Dashboard
🔐 Two-Factor Authentication (2FA)

---

## 👨‍💻 Authors

| 🧑‍🎓 Name     | 🌐 Profile URL                                                  |
| -------------- | --------------------------------------------------------------- |
| Nayan Padhiyar | [@Nayan8319](https://github.com/Nayan8319)                      |
| Harsh Tailor   | [LinkedIn](https://www.linkedin.com/in/harsh-tailor-x27/)       |
| Pratham Sali   | [LinkedIn](https://www.linkedin.com/in/pratham-sali-7244a4216/) |

🎓 Submitted as part of **BCA Semester 6** at *Udhna Citizen Commerce College*, under the guidance of **Mr. Ronak Shah**

---

## 🔗 References

* 🌐 [Tailwind UI](https://tailwindui.com/)
* 🌐 [React.dev](https://react.dev/)
* 📺 [Flask Docs](https://flask.palletsprojects.com/en/2.3.x/tutorial/)
* 🗄️ [MongoDB](https://www.mongodb.com/try/download/community)
* 🎥 [YouTube](https://www.youtube.com/)

---

## 📄 License

📚 This repository is for **educational purposes only**. All rights reserved by the author. 📘

---

> 💬 *“Make numbers talk. Let data drive your decisions.”*

🌟 If you liked this project, don’t forget to **⭐ star it** and share it with others!
