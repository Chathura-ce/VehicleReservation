<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en"> <!--begin::Head-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>MegaCityCab::Register</title><!--begin::Primary Meta Tags-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="title" content="AdminLTE 4 | Login Page">
    <meta name="author" content="ColorlibHQ">
    <meta name="description" content="AdminLTE is a Free Bootstrap 5 Admin Dashboard, 30 example pages using Vanilla JS.">
    <meta name="keywords" content="bootstrap 5, bootstrap, bootstrap 5 admin dashboard, bootstrap 5 dashboard, bootstrap 5 charts, bootstrap 5 calendar, bootstrap 5 datepicker, bootstrap 5 tables, bootstrap 5 datatable, vanilla js datatable, colorlibhq, colorlibhq dashboard, colorlibhq admin dashboard"><!--end::Primary Meta Tags--><!--begin::Fonts-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fontsource/source-sans-3@5.0.12/index.css" integrity="sha256-tXJfXfp6Ewt1ilPzLDtQnJV4hclT9XuaZUKyUvmyr+Q=" crossorigin="anonymous"><!--end::Fonts--><!--begin::Third Party Plugin(OverlayScrollbars)-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.3.0/styles/overlayscrollbars.min.css" integrity="sha256-dSokZseQNT08wYEWiz5iLI8QPlKxG+TswNRD8k35cpg=" crossorigin="anonymous"><!--end::Third Party Plugin(OverlayScrollbars)--><!--begin::Third Party Plugin(Bootstrap Icons)-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.min.css" integrity="sha256-Qsx5lrStHZyR9REqhUF8iQt73X06c8LGIUPzpOhwRrI=" crossorigin="anonymous"><!--end::Third Party Plugin(Bootstrap Icons)--><!--begin::Required Plugin(AdminLTE)-->
    <link rel="stylesheet" href="css/adminlte.css"><!--end::Required Plugin(AdminLTE)-->
    <style>
        .registration-container {
            min-height: 100vh;
            width: 100%;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
        }
        .registration-card {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .car-image-col {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('/assets/img/registratin800x1200.jpg') center/cover no-repeat;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            padding: 2rem;
        }
        .form-control, .input-group-text {
            border-radius: 8px;
        }
        .input-group-text {
            background-color: transparent;
        }
        .btn-register {
            background-color: #4e73df;
            border: none;
            border-radius: 8px;
            padding: 10px;
            font-weight: 600;
        }
        .btn-register:hover {
            background-color: #375ad3;
        }
        .brand-logo {
            font-size: 2.5rem;
            font-weight: 700;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        .brand-tagline {
            font-size: 1.2rem;
            margin-top: 1rem;
            text-align: center;
        }
    </style>
</head> <!--end::Head--> <!--begin::Body-->

<body class="login-page bg-body-secondary">
<div class="registration-container d-flex align-items-center justify-content-center">
    <div class="container py-5">
        <div class="row g-0 registration-card">
            <!-- Left side - Image with overlay -->
            <div class="col-md-5 car-image-col d-none d-md-flex">
                <div class="brand-logo">CityCab</div>
                <div class="brand-tagline">Your journey begins with us. Premium cars for every occasion.</div>
            </div>

            <!-- Right side - Registration form -->
            <div class="col-md-7 bg-white p-4 p-md-5">
                <div class="text-center mb-4">
                    <h2 class="h4 mb-1">Create Your CityCab Account</h2>
                    <p class="text-muted">Join today to explore our fleet and enjoy exclusive benefits</p>
                </div>

                <!-- Display Validation Errors -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="register" method="post">
                    <div class="input-group mb-3">
                            <span class="input-group-text">
                                <i class="bi bi-person-fill"></i>
                            </span>
                        <input type="text" class="form-control" name="username" placeholder="Username"
                               value="${username != null ? username : ''}" required>
                    </div>

                    <div class="input-group mb-3">
                            <span class="input-group-text">
                                <i class="bi bi-lock-fill"></i>
                            </span>
                        <input type="password" class="form-control" name="password" placeholder="Password"
                               value="${password != null ? password : ''}" required>
                    </div>

                    <div class="input-group mb-3">
                            <span class="input-group-text">
                                <i class="bi bi-card-heading"></i>
                            </span>
                        <input type="text" class="form-control" name="fullName" placeholder="Full Name"
                               value="${fullName != null ? fullName : ''}" required>
                    </div>

                    <div class="input-group mb-3">
                            <span class="input-group-text">
                                <i class="bi bi-house-door-fill"></i>
                            </span>
                        <textarea class="form-control" name="address" placeholder="Address" required>${address != null ? address : ''}</textarea>
                    </div>

                    <div class="input-group mb-3">
                            <span class="input-group-text">
                                <i class="bi bi-file-person"></i>
                            </span>
                        <input type="text" class="form-control" name="nic" placeholder="NIC"
                               value="${nic != null ? nic : ''}" required>
                    </div>

                    <div class="input-group mb-3">
                            <span class="input-group-text">
                                <i class="bi bi-telephone-fill"></i>
                            </span>
                        <input type="text" class="form-control" name="phoneNumber" placeholder="Phone Number"
                               value="${phoneNumber != null ? phoneNumber : ''}" required>
                    </div>

                    <div class="input-group mb-4">
                            <span class="input-group-text">
                                <i class="bi bi-envelope-fill"></i>
                            </span>
                        <input type="email" class="form-control" name="email" placeholder="Email"
                               value="${email != null ? email : ''}">
                    </div>

                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary btn-register w-100">Create Account</button>
                    </div>

                    <div class="text-center">
                        <p class="mb-0">Already have an account? <a href="login.jsp" class="text-decoration-none">Sign In</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.3.0/browser/overlayscrollbars.browser.es6.min.js" integrity="sha256-H2VM7BKda+v2Z4+DRy69uknwxjyDRhszjXFhsL4gD3w=" crossorigin="anonymous"></script> <!--end::Third Party Plugin(OverlayScrollbars)--><!--begin::Required Plugin(popperjs for Bootstrap 5)-->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha256-whL0tQWoY1Ku1iskqPFvmZ+CHsvmRWx/PIoEvIeWh4I=" crossorigin="anonymous"></script> <!--end::Required Plugin(popperjs for Bootstrap 5)--><!--begin::Required Plugin(Bootstrap 5)-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha256-YMa+wAM6QkVyz999odX7lPRxkoYAan8suedu4k2Zur8=" crossorigin="anonymous"></script> <!--end::Required Plugin(Bootstrap 5)--><!--begin::Required Plugin(AdminLTE)-->
<script src="js/adminlte.js"></script> <!--end::Required Plugin(AdminLTE)--><!--begin::OverlayScrollbars Configure-->

