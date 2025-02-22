<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>
<div class="row">
    <div class="col-sm-6">
        <h3 class="mb-0">Driver</h3>
    </div>
    <div class="col-sm-6">
        <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item"><a href="#">Driver</a></li>
            <li class="breadcrumb-item active" aria-current="page">
                Drivers List
            </li>
        </ol>
    </div>
</div>

<div class="row d-flex justify-content-center mt-5">
    <div class="col-sm-12">
        <div class="card card-primary">
            <div class="card-header">
                <h3 class="card-title">Drivers List</h3>
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


                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Driver ID.</th>
                        <th>User Name</th>
                        <th>Name</th>
                        <th>License Number</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="driver" items="${driverList}">
                        <tr>
                            <td>${driver.driverId}</td>
                            <td>${driver.user.username}</td>
                            <td>${driver.user.fullName}</td>
                            <td>${driver.licenseNumber}</td>
                            <td>${driver.user.phone}</td>
                            <td>${driver.user.status}</td>
                            <td>
                                <a class="btn btn-primary" href="edit-driver?driverId=${driver.driverId}">
                                    Edit
                                </a>
                            </td>
                            <td>
                                <form action="delete-driver" method="post" onsubmit="return confirm('Are you sure you want to delete this driver?');">
                                    <input type="hidden" name="driverId" value="${driver.driverId}">
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>


<%@ include file="../footer.jsp" %>