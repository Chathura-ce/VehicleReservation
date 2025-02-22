<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<div class="row">
    <div class="col-sm-6">
        <h3 class="mb-0">Dashboard</h3>
    </div>
    <div class="col-sm-6">
        <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">
                Dashboard
            </li>
        </ol>
    </div>
</div>

<div class="row d-flex justify-content-center mt-5">
    <div class="col-sm-8">
        <div class="card card-primary">
            <div class="card-header">
                <h3 class="card-title">Add New Driver</h3>
            </div>
            <div class="card-body">
                <!-- Display Validation Errors Using Scriptlets -->
                <%
                    String errorMessage = (String) session.getAttribute("errorMessage");
                    if (errorMessage != null && !errorMessage.trim().isEmpty()) {
                %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= errorMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                        // Remove the attribute so it doesn't persist
                        session.removeAttribute("errorMessage");
                    }
                %>

                <!-- Display Success Message Using Scriptlets -->
                <%
                    String successMessage = (String) session.getAttribute("successMessage");
                    if (successMessage != null && !successMessage.trim().isEmpty()) {
                %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= successMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                        // Remove the attribute so it doesn't persist
                        session.removeAttribute("successMessage");
                    }
                %>


                <form action="${pageContext.request.contextPath}/add-driver" method="post">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="username" placeholder="Username"
                               value="${username != null ? username : ''}" required>
                        <div class="input-group-text">
                            <span class="bi bi-person-fill"></span>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <!-- Do not prefill password for security -->
                        <input type="password" class="form-control" name="password" placeholder="Password"
                               value="${password != null ? password : ''}" required>
                        <div class="input-group-text">
                            <span class="bi bi-lock-fill"></span>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="fullName" placeholder="Full Name"
                               value="${fullName != null ? fullName : ''}" required>
                        <div class="input-group-text">
                            <span class="bi bi-card-heading"></span>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <textarea class="form-control" name="address" placeholder="Address" required>${address != null ? address : ''}</textarea>
                        <div class="input-group-text">
                            <span class="bi bi-house-door-fill"></span>
                        </div>
                    </div>

                    <%--<div class="input-group mb-3">
                        <input type="text" class="form-control" name="nic" placeholder="NIC"
                               value="${nic != null ? nic : ''}" required>
                        <div class="input-group-text">
                            <span class="bi bi-file-person"></span>
                        </div>
                    </div>--%>

                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="phoneNumber" placeholder="Phone Number"
                               value="${phoneNumber != null ? phoneNumber : ''}" required>
                        <div class="input-group-text">
                            <span class="bi bi-telephone-fill"></span>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input type="email" class="form-control" name="email" placeholder="Email"
                               value="${email != null ? email : ''}">
                        <div class="input-group-text">
                            <span class="bi bi-envelope-fill"></span>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="licenseNumber" placeholder="License Number"
                               value="${license != null ? license : ''}">
                        <div class="input-group-text">
                            <span class="bi bi-person-badge"></span>
                        </div>
                    </div>
                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary">Add Driver</button>
                    </div>

                </form>
            </div>
        </div>

    </div>
</div>


<%@ include file="../footer.jsp" %>