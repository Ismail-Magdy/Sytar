<div align="center">
  <img src="URL_HERE" width="100%" alt="Sytar App Banner">

  <h1> Sytar (سيطر) - Your Smart Academic Assistant</h1>

  <p>
    <strong>A proactive, gamified, and intelligent academic companion designed for university students.</strong>
  </p>

  <p>
    <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
    <img src="https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase" alt="Firebase" />
    <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
    <img src="https://img.shields.io/badge/BLoC-State_Management-blue?style=for-the-badge" alt="BLoC" />
  </p>
</div>

---

## About The Project

Welcome to **Sytar (سيطر)** Born out of the vision to create something uniquely tailored for university students, Sytar is not just another traditional GPA calculator. It is a comprehensive, smart academic assistant designed to stay with students throughout all their college years. 

From the beginning of each semester, Sytar takes charge. Students input their subjects, grading breakdown (coursework, quizzes, practicals, midterms, finals), and their target grades. Sytar then acts as a proactive companion analyzing performance, tracking missing marks, and ensuring you never miss a deadline. 

With Sytar, the goal is simple: **Take Control** of your academic journey.

##  Key Features

-  **Smart Assistant:** Analyzes your grading breakdown, calculates what you need to achieve your target grade, and provides personalized tips to raise your GPA.
-  **Proactive Notifications & Reminders:** Smart alerts for upcoming exams, quizzes, midterm months, and pending tasks so you're never caught off guard.
-  **Grade Gamification:** Motivational Lottie animations and interactive feedback based on your academic performance to keep you engaged and striving for excellence.
-  **Robust Offline Mode:** Powered by a built-in Network Cubit, Sytar elegantly handles offline states across the entire app. Your data is always accessible, with or without an internet connection.
-  **Task Management:** Link tasks and assignments to specific subjects with customizable deadlines.

## App Previews

<table align="center">
  <tr>
    <td align="center"><img src="LINK_TO_SCREENSHOT_1" width="200px;" alt="Home Screen"/><br /><b>Home Dashboard</b></td>
    <td align="center"><img src="LINK_TO_SCREENSHOT_2" width="200px;" alt="Subjects Screen"/><br /><b>Subjects & Grades</b></td>
    <td align="center"><img src="LINK_TO_SCREENSHOT_3" width="200px;" alt="Task Manager"/><br /><b>Smart Task Manager</b></td>
  </tr>
  <tr>
    <td align="center"><img src="LINK_TO_SCREENSHOT_4" width="200px;" alt="Notifications"/><br /><b>Proactive Alerts</b></td>
    <td align="center"><img src="LINK_TO_SCREENSHOT_5" width="200px;" alt="GPA Calculator"/><br /><b>GPA Insights</b></td>
    <td align="center"><img src="LINK_TO_SCREENSHOT_6" width="200px;" alt="Profile"/><br /><b>Student Profile</b></td>
  </tr>
</table>

##  Tech Stack & Architecture

Sytar is built with a focus on high-quality code, scalability, and an exceptional user experience.

- **Architecture:** Strict Feature-Based Clean Architecture (Separation of Data, Manager, and Presentation layers per feature).
- **State Management:** BLoC & Cubit.
- **Backend as a Service (BaaS):** Firebase (Firestore, Authentication).
- **Dependency Injection:** GetIt (Utilizing Lazy Singletons & Factories for efficient memory management).
- **UI/UX Magic:** 
  - `flutter_screenutil` for pixel-perfect responsiveness across all devices.
  - `lottie` for engaging, gamified animations.
  - Custom Interactive BottomSheets & Glassmorphism navigation for a premium feel.
- **Network Handling:** Custom Network Cubit for seamless offline/online state transitions.

##  Folder Structure

Here's a glimpse into the clean, feature-based architecture that powers Sytar:

```text
lib/
 ┣ core/               # Shared utilities, constants, themes, and network handling
 ┣ features/           # Feature-based clean architecture modules
 ┃ ┣ auth/
 ┃ ┃ ┣ data/           # Models, Repositories, Data Sources
 ┃ ┃ ┣ manager/        # BLoC / Cubit for state management
 ┃ ┃ ┗ presentation/   # UI: Screens and Widgets
 ┃ ┣ home/
 ┃ ┣ subjects/
 ┃ ┗ tasks/
 ┣ injection_container.dart # GetIt dependency injection setup
 ┗ main.dart           # App entry point
```

##  Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- A Firebase project setup (Add your `google-services.json` and `GoogleService-Info.plist`)

### Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/Ismail-Magdy/Sytar.git
   ```
2. Navigate to the project directory:
   ```bash
   cd sytar
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

##  Connect with Me

Developed with passion by **Ismail Magdy**.  
Let's connect and talk about Flutter, Clean Architecture, and building great products

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ismailmagdy021/)
