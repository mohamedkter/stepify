# Stepify 👟

**Stepify** is a modern and stylish Flutter-based mobile application for browsing, buying, and managing sneakers. It features a clean UI, user authentication, product filtering, and Firebase backend integration.

## ✨ Features

- 🔐 User Authentication (Login/Register with Firebase)
- 🏠 Home Screen with Categories & Featured Sneakers
- 🔍 Search Functionality
- 🛒 Add to Cart & Checkout Flow 
- 📦 Product Details with multiple images, sizes, colors
- 🧾 Order History 
- 🧑‍💼 User Profile Management
- ☁️ Cloudinary Image Hosting
- 🌐 Multi-language Support  (coming soon)
- 🔔 Real-time Notifications (planned)

## 🛠️ Tech Stack

- **Flutter** – Frontend framework
- **Firebase Auth & Firestore** – User auth & database
- **Cloudinary** – Image hosting
- **Provider / Bloc / Cubit** – State Management (based on your setup)
- **ScreenUtil** – Responsive UI
- **Google Fonts** – Custom typography

## 📱 Screens Overview

| Screen               | Description                               |
|----------------------|-------------------------------------------|
| Splash Screen        | App logo and loading indicator            |
| Onboarding Screens   | Intro to Stepify features                 |
| Login / Register     | User authentication via Firebase          |
| Home Screen          | Categories, featured products             |
| Product Details      | View shoe info, sizes, images, rating     |
| Search Screen        | Find shoes based on name/tags             |
| Cart Screen          | Selected items and total price (optional) |
| Profile Screen       | View/update user info                     |

## 📦 Installation

```bash
git clone https://github.com/your-username/stepify.git
cd stepify
flutter pub get
flutter run
