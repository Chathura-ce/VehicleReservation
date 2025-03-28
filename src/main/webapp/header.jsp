<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%@ page import="java.util.Objects" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        session.setAttribute("errorMessage", "Your session expired. Please Login.");
        response.sendRedirect("/login.jsp"); // Redirect to login page
        return; // Stop further execution
    }
%>
<!DOCTYPE html>
<html lang="en"> <!--begin::Head-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Mega City Cab</title><!--begin::Primary Meta Tags-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="title" content="AdminLTE v4 | Dashboard">
    <meta name="author" content="Chathura">
    <meta name="description"
          content="AdminLTE is a Free Bootstrap 5 Admin Dashboard, 30 example pages using Vanilla JS.">
    <meta name="keywords"
          content="bootstrap 5, bootstrap, bootstrap 5 admin dashboard, bootstrap 5 dashboard, bootstrap 5 charts, bootstrap 5 calendar, bootstrap 5 datepicker, bootstrap 5 tables, bootstrap 5 datatable, vanilla js datatable, colorlibhq, colorlibhq dashboard, colorlibhq admin dashboard">
    <!--end::Primary Meta Tags--><!--begin::Fonts-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fontsource/source-sans-3@5.0.12/index.css"
          integrity="sha256-tXJfXfp6Ewt1ilPzLDtQnJV4hclT9XuaZUKyUvmyr+Q=" crossorigin="anonymous"><!--end::Fonts-->
    <!--begin::Third Party Plugin(OverlayScrollbars)-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.3.0/styles/overlayscrollbars.min.css"
          integrity="sha256-dSokZseQNT08wYEWiz5iLI8QPlKxG+TswNRD8k35cpg=" crossorigin="anonymous">
    <!--end::Third Party Plugin(OverlayScrollbars)--><!--begin::Third Party Plugin(Bootstrap Icons)-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.min.css"
          integrity="sha256-Qsx5lrStHZyR9REqhUF8iQt73X06c8LGIUPzpOhwRrI=" crossorigin="anonymous">
    <!--end::Third Party Plugin(Bootstrap Icons)--><!--begin::Required Plugin(AdminLTE)-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminlte.css">
    <!--end::Required Plugin(AdminLTE)--><!-- apexcharts -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/apexcharts@3.37.1/dist/apexcharts.css"
          integrity="sha256-4MX+61mt9NVvvuPjUWdUdyfZfxSB1/Rf9WtqRHgG5S0=" crossorigin="anonymous"><!-- jsvectormap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jsvectormap@1.5.3/dist/css/jsvectormap.min.css"
          integrity="sha256-+uGLJmmTKOqBr+2E6KDYs/NRsHxSkONXFHUL0fy2O/4=" crossorigin="anonymous">
    <style>
        input:read-only {
            background-color: #eee !important;
        }
    </style>
</head> <!--end::Head--> <!--begin::Body-->

<body class="layout-fixed sidebar-expand-lg bg-body-tertiary"> <!--begin::App Wrapper-->
<div class="app-wrapper"> <!--begin::Header-->
    <nav class="app-header navbar navbar-expand bg-body"> <!--begin::Container-->
        <div class="container-fluid"> <!--begin::Start Navbar Links-->
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" data-lte-toggle="sidebar" href="#" role="button"> <i
                        class="bi bi-list"></i> </a></li>
                <li class="nav-item d-none d-md-block"><a href="${pageContext.request.contextPath}/home.jsp"
                                                          class="nav-link">Home</a></li>
            </ul> <!--end::Start Navbar Links--> <!--begin::End Navbar Links-->
            <ul class="navbar-nav ms-auto"> <!--begin::Navbar Search-->
                <li class="nav-item dropdown user-menu"><a href="#" class="nav-link dropdown-toggle"
                                                           data-bs-toggle="dropdown"> <img src="/assets/img/admin-avatar.jpg" class="user-image rounded-circle shadow"
                        alt="User Image"> <span class="d-none d-md-inline">${loggedInUser.fullName}</span> </a>
                    <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-end"> <!--begin::User Image-->
                        <li class="user-header text-bg-primary"><img src="/assets/img/admin-avatar.jpg"
                                                                     class="rounded-circle shadow" alt="User Image">
                            <p>
                                ${loggedInUser.fullName}
                                <small>Member since ${loggedInUser.createdAt}</small>
                            </p>
                        </li> <!--end::User Image--> <!--begin::Menu Body-->
                        <li class="user-footer"><a href="#" class="btn btn-default btn-flat"></a> <a
                                href="/logout"
                                class="btn btn-default btn-flat float-end">Sign out</a></li> <!--end::Menu Footer-->
                    </ul>
                </li> <!--end::User Menu Dropdown-->
            </ul> <!--end::End Navbar Links-->
        </div> <!--end::Container-->
    </nav> <!--end::Header--> <!--begin::Sidebar-->
    <aside class="app-sidebar bg-body-secondary shadow" data-bs-theme="dark"> <!--begin::Sidebar Brand-->
        <div class="sidebar-brand"> <!--begin::Brand Link--> <a href="./index.html" class="brand-link">
            <!--begin::Brand Image--> <img style="display:none" src="" alt=""
                                           class="brand-image opacity-75 shadow"> <!--end::Brand Image-->
            <!--begin::Brand Text--> <span class="brand-text fw-light">Mega City Cab</span> <!--end::Brand Text--> </a>
            <!--end::Brand Link--> </div> <!--end::Sidebar Brand--> <!--begin::Sidebar Wrapper-->
        <div class="sidebar-wrapper">
            <nav class="mt-2"> <!--begin::Sidebar Menu-->
                <ul class="nav sidebar-menu flex-column" data-lte-toggle="treeview" role="menu" data-accordion="false">
                    <% if (loggedInUser == null || Objects.equals(loggedInUser.getRole(), "admin")) { %>
                    <li class="nav-item"><a href="#" class="nav-link "> <i
                            class="nav-icon bi bi-speedometer"></i>
                        <p>
                            Driver
                            <i class="nav-arrow bi bi-chevron-right"></i>
                        </p>
                    </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item"><a href="/driver/add-driver.jsp" class="nav-link"> <i
                                    class="nav-icon bi bi-circle"></i>
                                <p>Add Driver</p>
                            </a></li>
                            <li class="nav-item"><a href="${pageContext.request.contextPath}/list-drivers"
                                                    class="nav-link"> <i
                                    class="nav-icon bi bi-circle"></i>
                                <p>Drivers List</p>
                            </a></li>
                        </ul>
                    </li>

                    <li class="nav-item"><a href="#" class="nav-link "> <i
                            class="nav-icon bi bi-car-front"></i>
                        <p>
                            Car
                            <i class="nav-arrow bi bi-chevron-right"></i>
                        </p>
                    </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item"><a href="${pageContext.request.contextPath}/add-car"
                                                    class="nav-link "> <i
                                    class="nav-icon bi bi-circle"></i>
                                <p>Add Car</p>
                            </a></li>
                            <li class="nav-item"><a href="${pageContext.request.contextPath}/list-cars"
                                                    class="nav-link"> <i
                                    class="nav-icon bi bi-circle"></i>
                                <p>Cars List</p>
                            </a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a href="#" class="nav-link "> <i
                            class="nav-icon bi bi-calendar-check"></i>
                        <p>
                            Bookings
                            <i class="nav-arrow bi bi-chevron-right"></i>
                        </p>
                    </a>
                        <% if (loggedInUser != null && Objects.equals(loggedInUser.getRole(), "admin")) { %>
                        <ul class="nav nav-treeview">
                            <li class="nav-item"><a
                                    href="${pageContext.request.contextPath}/booking/new"
                                    class="nav-link "> <i
                                    class="nav-icon bi bi-plus-circle"></i>
                                <p>Create Booking</p>
                            </a></li>
                            <li class="nav-item"><a href="${pageContext.request.contextPath}/booking/all-bookings"
                                                    class="nav-link"> <i
                                    class="nav-icon bi bi-list-ul"></i>
                                <p>All Bookings</p>
                            </a></li>
                        </ul>
                        <% } %>
                    </li>
                    <li style="display: none" class="nav-item"><a href="./generate/theme.html" class="nav-link"> <i
                            class="nav-icon bi bi-palette"></i>
                        <p>Theme Generate</p>
                    </a></li>
                    <% } %>

                    <% if (loggedInUser == null || Objects.equals(loggedInUser.getRole(), "driver")) { %>
                    <li class="nav-item"><a href="/driver-dashboard/assigned-bookings" class="nav-link"> <i class="nav-icon bi bi-palette"></i>
                        <p>Assigned Bookings</p>
                    </a></li>
                    <% } %>
                </ul>

                <!--end::Sidebar Menu-->
            </nav>
        </div> <!--end::Sidebar Wrapper-->
    </aside> <!--end::Sidebar--> <!--begin::App Main-->
    <main class="app-main"> <!--begin::App Content Header-->
        <div class="app-content-header"> <!--begin::Container-->
            <div class="container-fluid"> <!--begin::Row-->

