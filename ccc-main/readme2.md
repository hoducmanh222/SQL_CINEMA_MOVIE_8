# Cinema Management System - Detailed Project Summary

## Main Functionalities

- **Movie Management**
  - Add, edit, and delete movie records.
  - Manage genres and movie durations.
  - View all movies in a sortable table.
  - Display average ratings for each movie (from feedback).
  - Add new genres directly from the movie management interface.

- **Cinema Room Management**
  - Add, edit, and delete cinema rooms.
  - Track room names and seating capacity.
  - Visual seat layout preview for each room (all seats shown as unbooked/green).
  - Prevent deletion of rooms in use by screenings.

- **Screening Schedule Management**
  - Assign movies to rooms at specific dates and times.
  - Edit and delete screening schedules.
  - View all screenings in a sortable table with occupancy percentage.
  - Select movie and room from dropdowns populated with current data.
  - Prevent scheduling conflicts and ensure valid time/date input.

- **Customer Management**
  - Add, edit, and delete customer records.
  - Store customer name and phone number.
  - Autocomplete and search for customers by phone number.
  - Prevent duplicate phone numbers.
  - Update customer information and reflect changes across the system.

- **Ticket Booking and Seat Selection**
  - Book tickets for screenings with a visual seat selection grid.
  - Display available and occupied seats (green for available, red for booked, blue for selected).
  - Prevent double-booking and enforce seat availability at the database level.
  - Autocomplete customer info by phone number or add new customers on the fly.
  - Book tickets with audit logging of the user performing the action.
  - Cancel tickets and maintain a cancellation audit trail.
  - Manual and automatic refresh of seat and screening data for real-time accuracy.

- **Ticket History**
  - View all tickets (active and cancelled) in a sortable table.
  - Filter tickets by status (All, Active, Cancelled).
  - Cancel tickets directly from the history view.
  - View audit log of all booking and cancellation operations.

- **Feedback Management**
  - Add, edit, and delete feedback for movies.
  - Filter feedback by movie or customer.
  - Display feedback with star ratings and comments.
  - Update movie ratings in real time based on feedback.
  - Prevent duplicate feedback for the same customer/movie pair.

- **Reporting**
  - Generate reports on ticket sales, screenings, and occupancy rates.
  - View popular movies by ticket sales.
  - Visualize occupancy rates and revenue with charts (matplotlib).
  - Filter reports by date, movie, or room.
  - Export or print reports as needed.

## Database Security and Administration

- **Role-Based Access Control**
  - Assign roles (admin, ticket clerk) to users.
  - Restrict access to sensitive features based on role (e.g., only admin can manage movies, rooms, screenings, and reports).
  - Clerk can manage customers, book tickets, and view ticket history.

- **Data Security**
  - Secure customer information in the database.
  - Passwords stored as SHA2 hashes.
  - (Optional) Secure payment history if implemented.

- **Backups and Recovery**
  - Automated backup script (`database/backup_db.py`) using `mysqldump` with timestamped filenames.
  - Backups stored in a dedicated `backups` folder.
  - Instructions for restoring from backup files using MySQL command line.

- **Performance Optimization**
  - Database indexes on key columns (e.g., ScreeningID, MovieID, RoomID, SeatNumber, PhoneNumber).
  - Use of connection pooling in the Python backend for efficient resource usage.
  - Optimized SQL queries for screening and ticket lookups.
  - Use of stored procedures and triggers for booking/cancellation logic and audit logging.

## Python Application Development

- **Database Connection**
  - Uses `mysql-connector-python` for all database operations.
  - Centralized connection logic in `database/db_connector.py`.
  - Connection pooling for efficient and scalable access.
  - Automatic reconnection and error handling.

- **Booking System**
  - Python functions for seat booking, cancellation, and audit logging in `models/ticket_model.py`.
  - Triggers and stored procedures in MySQL for integrity and audit.
  - Visual seat selection grid in the GUI (`gui/ticket_booking.py`).
  - Prevents double-booking at both application and database levels.

- **Reporting**
  - Python code to generate and display screening and sales reports (`models/report_model.py`, `gui/reports.py`).
  - Visualizations using matplotlib embedded in Tkinter frames.
  - Real-time data refresh and filtering options.

- **User Interface**
  - Tkinter-based GUI for all booking, management, and reporting operations.
  - Modular design: each major function is a separate Frame in the `gui` folder:
    - `movie_management.py`: Movie and genre management.
    - `cinema_room_management.py`: Cinema room and seat layout management.
    - `screening_management.py`: Screening schedule management.
    - `customer_management.py`: Customer information management.
    - `ticket_booking.py`: Ticket booking and seat selection.
    - `ticket_history.py`: Ticket history and audit log.
    - `feedback_management.py`: Feedback and rating management.
    - `reports.py`: Reporting and analytics.
    - `main_window.py`: Main application window and navigation.
    - `login_window.py`: Secure login with role selection.
  - Manual and automatic refresh options for real-time data.
  - Dashboard with charts and quick navigation for admins and clerks.
  - Role-based menu and feature access.

---

**Note:**  
- The system is designed for extensibility and security, with clear separation of concerns between database, business logic, and user interface.
- All critical operations (booking, cancellation, management) are logged for audit purposes.
- The codebase is modular and ready for further enhancements, such as payment integration or web-based UI.
- For setup, see the main `README.md` for installation and running instructions.

