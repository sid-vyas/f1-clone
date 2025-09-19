# 🏎️ F1 Mobile App Clone

A cross-platform Formula 1 mobile app built with **Flutter** (frontend) and **Node.js/Express** (backend).  
The app displays race schedules, driver & team standings, and past season results using the [Jolpica F1 API](https://github.com/jolpica/jolpica-f1).

---

## ✨ Features
- 📅 View upcoming & past **race schedules**
- 👨‍🚀 **Driver standings** with team logos and colors
- 🏆 **Team standings** with performance insights
- 📊 Access **previous season results**
- 🎨 Custom theming with F1 team colors & logos
- ⚡ Backend integration with Jolpica F1 API
- 📱 Runs on Android (iOS support possible)

---

## 🛠️ Tech Stack
### Frontend
- [Flutter](https://flutter.dev/) (Dart)
- `http` package for API calls
- `BottomNavigationBar` for navigation
- Asset-based team logos & dynamic theming

### Backend
- [Node.js](https://nodejs.org/) + [Express](https://expressjs.com/)
- Acts as a middleware to fetch and clean data from Jolpica API
- REST endpoints:  
  - `/drivers`
  - `/teams`
  - `/standings`
  - `/schedule`
  - `/results`

---
