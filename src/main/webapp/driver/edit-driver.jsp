<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<%@ page import="util.FlashMessageUtil" %>
<div class="row">
    <div class="col-sm-6">
        <h3 class="mb-0">Driver</h3>
    </div>
    <div class="col-sm-6">
        <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item"><a href="#">Driver</a></li>
            <li class="breadcrumb-item active" aria-current="page">
                Edit Driver
            </li>
        </ol>
    </div>
</div>
<%--<div class="card">--%>
<%--    <div class="card-body">--%>
<div class="row d-flex justify-content-center mt-5">
    <div class="col-sm-8">
        <div class="card card-primary">
            <div class="card-header">
                <h3 class="card-title">Edit Driver</h3>
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


                <form action="${pageContext.request.contextPath}/edit-driver" method="post">
                    <input type="hidden" name="driverId" value="${driver.driverId}"/>
                    <input type="hidden" name="userId" value="${driver.user.userId}"/>

                    <!-- Username and Password in one row -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="username" class="form-label">Username</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="username" name="username"
                                       placeholder="Enter username"
                                       value="${driver.user.username}" required>
                                <div class="input-group-text">
                                    <span class="bi bi-person-fill"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="password" class="form-label">New Password (Optional)</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="Leave blank to keep the current password" value="">
                                <div class="input-group-text">
                                    <span class="bi bi-lock-fill"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <!-- Full Name -->
                        <div class="col-md-6">
                            <label for="fullName" class="form-label">Full Name</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="fullName" name="fullName"
                                       placeholder="Enter full name"
                                       value="${driver.user.fullName}" required>
                                <div class="input-group-text">
                                    <span class="bi bi-card-heading"></span>
                                </div>
                            </div>
                        </div>
                        <!-- NIC -->
                        <div class="col-md-6 mb-3">
                            <label for="nic" class="form-label">NIC</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="nic" name="nic"
                                       placeholder="NIC" value="${driver.user.nic}" required>
                                <div class="input-group-text">
                                    <span class="bi bi-file-person"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Phone Number and License Number in one row -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="phoneNumber" class="form-label">Phone Number</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber"
                                       placeholder="Enter phone number"
                                       value="${driver.user.phone}" required>
                                <div class="input-group-text">
                                    <span class="bi bi-telephone-fill"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="licenseNumber" class="form-label">License Number</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="licenseNumber" name="licenseNumber"
                                       placeholder="Enter license number"
                                       value="${driver.licenseNumber}">
                                <div class="input-group-text">
                                    <span class="bi bi-person-badge"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Email and Status Dropdown in one row -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email Address</label>
                            <div class="input-group">
                                <input type="email" class="form-control" id="email" name="email"
                                       placeholder="Enter email"
                                       value="${driver.user.email}">
                                <div class="input-group-text">
                                    <span class="bi bi-envelope-fill"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="status" class="form-label">Status</label>
                            <div class="input-group">
                                <select class="form-select" id="status" name="status">
                                    <option value="active" ${driver.user.status == 'Active' ? 'selected' : ''}>Active
                                    </option>
                                    <option value="inactive" ${driver.user.status == 'Inactive' ? 'selected' : ''}>
                                        Inactive
                                    </option>
                                </select>
                                <div class="input-group-text">
                                    <span class="bi bi-toggle-on"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <%--                        <button onclick="clearForm();" type="reset" class="btn btn-success">Reset</button>--%>
                        <button onclick="location.href='/list-drivers'" type="reset" class="btn btn-success">Back
                        </button>
                    </div>
                </form>


            </div>
        </div>

    </div>
</div>
<%--    </div>--%>
<%--</div>--%>


<%@ include file="../footer.jsp" %>

<script>
    function clearForm() {
        document.querySelector("form").reset(); // Resets to initial state
        document.querySelectorAll("input").forEach(input => input.value = ""); // Clears all input fields
        document.querySelectorAll("select").forEach(select => select.selectedIndex = 0); // Resets dropdowns
    }
</script>
