<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../header.jsp" %>
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h3 class="mb-0">Cars</h3>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Car</a></li>
                        <li class="breadcrumb-item active">List Cars</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <div class="content">
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">All Cars</h3>
                    <div class="card-tools">
                        <a href="${pageContext.request.contextPath}/add-car" class="btn btn-primary btn-sm">
                            <i class="fas fa-plus"></i> Add New Car
                        </a>
                    </div>
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

                    <table id="carTable" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Car Model</th>
                                <th>Reg Number</th>
                                <th>Seating Capacity</th>
                                <th>Availability</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="car" items="${carList}">
                                <tr>
                                    <td>${car.carId}</td>
                                    <td>${car.model}</td>
                                    <td>${car.regNumber}</td>
                                    <td>${car.seatingCapacity}</td>
                                    <td>
                                        <span class="badge ${car.available == 'Available' ? 'bg-success' : car.available == 'Booked' ? 'bg-warning' : 'bg-danger'}">
                                            ${car.available}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/edit-car?carId=${car.carId}" class="btn btn-info btn-sm">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="${pageContext.request.contextPath}/delete-car?carId=${car.carId}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this car?');">
                                            <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        $('#carTable').DataTable({
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": false,
            "responsive": true
        });
    });
</script>
<%@ include file="../footer.jsp" %>