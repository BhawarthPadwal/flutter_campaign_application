# 📢 Campaigny – Campaign Management App (Flutter + Full Stack)

**Campaigny** is a mobile application built with Flutter that allows users to create, manage, and explore campaigns easily. It is designed with scalability in mind, using BLoC for state management and a full backend stack for persistent data and authentication.

---

## 📚 Table of Contents

- [About The Project](#about-the-project)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [State Management](#state-management)
- [Routing](#routing)
- [API Reference](#api-reference)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgements](#acknowledgements)

---

## 📖 About The Project

Campaigny solves the problem of organizing and discovering public or private campaigns in a structured and user-friendly way. Built with Flutter and Firebase for authentication, it’s perfect for users looking to promote causes, run marketing campaigns, or organize events.

Backend is handled using **Express.js**, and data is stored securely in a **PostgreSQL** database.

---

## ✨ Features

- 🔐 Firebase Email/Password Authentication
- 🗂️ Create & View Campaigns
- 🌙 Dark and ☀️ Light Theme Toggle
- 📱 Responsive UI for Mobile
- 📦 RESTful API Integration (Express.js)
- 🧠 Clean BLoC Architecture
- 🛠️ PostgreSQL Integration via backend API

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK → [Install Flutter](https://flutter.dev/docs/get-started/install)
- Node.js & npm
- PostgreSQL installed and running locally or via cloud
- Firebase project with Email/Password Auth enabled

---

### 📦 Installation

#### Frontend (Flutter)

```bash
Got it! Here's your **entire README in a single continuous markdown block**, fully combined without breaking it into separate explanations:

---

````markdown
# 📢 Campaigny – Campaign Management App (Flutter + Full Stack)

**Campaigny** is a full-stack campaign management app that allows users to sign up, create, and explore campaigns with a smooth, responsive UI and powerful backend integration.

## 🚀 Getting Started

```bash
git clone https://github.com/BhawarthPadwal/flutter_campaign_application.git
cd flutter_campaign_application
flutter pub get
flutter run

git clone https://github.com/BhawarthPadwal/expressjs-postgres3.git
cd expressjs-postgres3
npm install
npm run dev
````

## 🧑‍💻 Usage

* Sign up or log in using your email and password.
* Create your first campaign by entering its title, description, and other details.
* Browse existing campaigns in the campaign feed.
* View and manage your own campaigns from the profile section.

## 🗂️ Project Structure

### Frontend (`lib/`)

```
├── blocs/               # BLoC files for state management
├── models/              # Data models
├── screens/             # UI Screens
├── services/            # API services
├── routes/              # Routing setup
├── themes/              # Light/Dark themes
└── main.dart
```

### Backend (`expressjs-postgres3/`)

```
├── controllers/         # Route handlers
├── routes/              # API route definitions
├── middleware/          # JWT and error handling
├── config/              # DB and Firebase config
└── server.js
```

## 🔄 State Management

This project uses the **BLoC (Business Logic Component)** pattern for predictable and scalable state management across screens. All async operations like campaign fetching, user auth, etc., are handled through BLoC streams and events.

## 🧭 Routing

All navigation is handled through **named routes**, defined in `lib/routes/routes.dart`. Custom page transitions are implemented using the `page_transition` package for a smooth UX.

## 🔌 API Reference

| Method | Endpoint         | Description         |
| ------ | ---------------- | ------------------- |
| POST   | `/auth/login`    | Login with Firebase |
| POST   | `/auth/register` | Register new user   |
| GET    | `/campaigns`     | Get all campaigns   |
| POST   | `/campaigns`     | Create new campaign |

## 🤝 Contributing

Contributions are welcome and appreciated!

1. Fork the project
2. Create a new branch: `git checkout -b feature/NewFeature`
3. Commit your changes: `git commit -m 'Add NewFeature'`
4. Push to the branch: `git push origin feature/NewFeature`
5. Open a Pull Request

Don’t forget to ⭐ the repo if you like it!

## 📝 License

Distributed under the **MIT License**. See `LICENSE.txt` for more information.

## 📬 Contact

**Bhawarth Padwal**
📧 [bhawarthpadwal@gmail.com](mailto:bhawarthpadwal7@gmail.com)
🔗 [LinkedIn](https://linkedin.com/in/bhawarth-padwal)
🔗 Frontend Repo: [GitHub - campaigny-frontend](https://github.com/BhawarthPadwal/flutter_campaign_application)
🔗 Backend Repo: [GitHub - campaigny-backend](https://github.com/BhawarthPadwal/expressjs-postgres3)
🎬 Video Demo: [Video](https://drive.google.com/file/d/1NZrvKHRHBGtWei_Z2qANSzLcq8MYeza0/view?usp=drive_link)

## 🙏 Acknowledgements

* Flutter & Firebase Docs
* Bloc Library by Felix Angelov
* PostgreSQL & Sequelize ORM
* Express.js Official Docs

```
