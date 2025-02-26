<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking List</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/header.jsp" />
    
    <div class="container mt-5">
        <div class="row mb-4">
            <div class="col">
                <h2>Booking List</h2>
            </div>
            <div class="col text-end">
                <a href="${pageContext.request.contextPath}/booking/new" class="btn btn-primary">Create New Booking</a>
            </div>
        </div>
        
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Booking ID</th>
                        <th>Pickup Location</th>
                        <th>Drop Location</th>
                        <th>Pickup Date & Time</th>
                        <th>Status</th>
                        <th>Fare</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td>${booking.bookingId}</td>
                            <td>${booking.pickupLocation}</td>
                            <td>${booking.dropLocation}</td>
                            <td><fmt:formatDate value="${booking.pickupDateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                            <td>
                                <span class="badge bg-${booking.status == 'Pending' ? 'warning' : 
                                    booking.status == 'Confirmed' ? 'success' : 
                                    booking.status == 'Completed' ? 'info' : 'danger'}">
                                    ${booking.status}
                                </span>
                            </td>
                            <td>$${booking.fare}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/booking/view?id=${booking.bookingId}" 
                                   class="btn btn-info btn-sm">View</a>
                                <c:if test="${sessionScope.userRole == 'admin'}">
                                    <form action="${pageContext.request.contextPath}/booking/update-status" method="post" 
                                          style="display: inline;">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <select name="status" class="form-select form-select-sm d-inline-block w-auto mx-1">
                                            <option value="Confirmed">Confirm</option>
                                            <option value="Completed">Complete</option>
                                            <option value="Cancelled">Cancel</option>
                                        </select>
                                        <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <c:if test="${empty bookings}">
            <div class="alert alert-info text-center">
                No bookings found.
            </div>
        </c:if>
    </div>
    
    <jsp:include page="/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>