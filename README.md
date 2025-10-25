# 🅿️ ParkEase: Vehicle Parking Management System

ParkEase is a robust, multi-user parking management system designed specifically for 4-wheeler vehicles. It offers distinct roles for administrators and users, real-time parking status, and automated backend processes for efficient management.

## Features

- **Admin & User Dashboards:** Comprehensive control for admins; intuitive parking management and history for users.
- **Automated Parking:** System allocates the first available spot, users manage park-in/park-out.
- **Scheduled Tasks:** Daily reminders, monthly activity reports, and on-demand CSV export of parking data.
- **Optimized Performance:** Enhanced response times through Redis caching.

## Technologies Used

- **Core:** Flask, Vue.js, SQLite
- **Caching & Task Queue:** Redis, Celery
- **Auth:** JWT-based Token Authentication (role-based access control)

## Database Schema

Key entities: `User`, `ParkingLot`, `ParkingSpot`, `ParkedVehicle` manage user data, parking areas, individual spots, and vehicle parking sessions.
