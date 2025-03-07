<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
            <table class="table table-bordered table-striped table-hover">
                <thead >
                    <tr>
                        <th>Booking ID</th>
                        <th>Pickup Location</th>
                        <th>Drop Location</th>
                        <th>Driver</th>
                        <th>Status</th>
                        <th>Fare</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${listBooking}">
                        <tr>
                            <td>${booking.bookingNumber}</td>
                            <td>${booking.pickupLocation}</td>
                            <td>${booking.destination}</td>
                            <td>${booking.driver.getDriverName()}</td>
                            <td>
                                <span class="badge bg-${booking.statusId == '1' ? 'warning' :
                                    booking.statusId == '2' ? 'success' :
                                    booking.statusId == '4' ? 'info' : 'danger'}">
                                        ${booking.statusId == '1' ? 'Pending' :
                                                booking.statusId == '2' ? 'Confirmed' :
                                                        booking.statusId == '4' ? 'Completed' : 'Cancelled'}
                                </span>
                            </td>
                            <td>$${booking.getTotalAmount()}</td>
                            <td>
                                <button onclick="printBill('${booking.bookingNumber}')" class="btn btn-success btn-sm">View</button>
                                <button onclick="editBooking('${booking.bookingNumber}')" class="btn btn-primary btn-sm">Edit</button>
                                <button onclick="printBill('${booking.bookingNumber}')" class="btn btn-danger btn-sm">Cancel</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>

    <jsp:include page="/footer.jsp" />

<script>
    function printBill(bookingNumber) {
        // Construct the URL for the new page with the booking number as a query parameter
        let url = '${pageContext.request.contextPath}/bill?bookingNumber=' + bookingNumber;

        // Open the new page in a new tab
        window.open(url, '_blank');
    }
    function editBooking(bookingNumber) {
        // Construct the URL for the new page with the booking number as a query parameter
        let url = '${pageContext.request.contextPath}/booking/new?bookingNumber=' + bookingNumber;

        // Open the new page in a new tab
        window.open(url, '_blank');
    }
</script>
