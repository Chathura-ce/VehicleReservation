<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mega City Cab - Your Reliable Cab Service in Colombo</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    .hero-section {
      background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('/assets/img/1600x800hero.jpg');
      background-size: cover;
      background-position: center;
      color: white;
      padding: 100px 0;
    }
    .feature-icon {
      font-size: 2.5rem;
      margin-bottom: 1rem;
      color: #ffc107;
    }
    .car-card {
      transition: all 0.3s;
      cursor: pointer;
      border: 2px solid transparent;
    }
    .car-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .car-specs {
      display: flex;
      flex-wrap: wrap;
      margin-bottom: 10px;
    }
    .car-spec-item {
      display: flex;
      align-items: center;
      margin-right: 15px;
      margin-bottom: 8px;
    }
    .car-spec-icon {
      width: 20px;
      text-align: center;
      margin-right: 5px;
      color: #6c757d;
    }
    .price-tag {
      font-size: 1.25rem;
      font-weight: 600;
      color: #212529;
    }
    .search-result-count {
      font-size: 0.9rem;
      color: #6c757d;
    }
  </style>
</head>
<body>
<div id="home"></div>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
  <div class="container">
    <a  class="navbar-brand" href="/home.jsp">
      <i class="fas fa-taxi me-2"></i>
      Mega City Cab
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link active" href="#home">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#about">About Us</a>
        </li>
        <%--                <li class="nav-item">--%>
        <%--                    <a class="nav-link" href="#contact">Contact</a>--%>
        <%--                </li> --%>
        <li class="nav-item">
          <c:choose>
            <c:when test="${empty sessionScope.loggedInUser}">
              <a class="nav-link text-warning ms-lg-3 px-4" href="login.jsp">
                <span class="login-text">Login</span>
                <i class="fas fa-sign-in-alt login-icon" style="display: none;"></i>
              </a>
            </c:when>
            <c:otherwise>
              <div class="dropdown">
                <button class="nav-link text-warning ms-lg-3 px-4 dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                  <span class="user-text"><i class="fas fa-user-circle me-1"></i>${sessionScope.loggedInUser.fullName}</span>
                  <i class="fas fa-user user-icon" style="display: none;"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                  <li><a class="dropdown-item" href="/customer-data/customer-profile"><i class="fas fa-user me-2"></i>Profile</a></li>
                  <li><a class="dropdown-item" href="/customer-booking/my-booking"><i class="fas fa-calendar-check me-2"></i>My Bookings</a></li>
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item" href="/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                </ul>
              </div>
            </c:otherwise>
          </c:choose>
        </li>
      </ul>
    </div>
  </div>
</nav>

