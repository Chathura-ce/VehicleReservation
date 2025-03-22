<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/header.jsp" />
<div class="row">
    <div class="col-sm-6">
        <h3 class="mb-0">My Booking</h3>
    </div>
    <div class="col-sm-6">
        <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item"><a href="#">Driver</a></li>
            <li class="breadcrumb-item active" aria-current="page">
                My Bookings
            </li>
        </ol>
    </div>
</div>
<div class="container mt-5">

    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover">
            <thead >
            <tr>
                <th>Booking ID</th>
                <th>Pickup Location</th>
                <th>Drop Location</th>
                <th>Status</th>
                <th style="width: 120px;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="booking" items="${assignedBookings}">
                <tr>
                    <td>${booking.bookingNumber}</td>
                    <td>${booking.pickupLocation}</td>
                    <td>${booking.destination}</td>
                    <td>
                                <span class="badge bg-${booking.statusId == '4' ? 'info' :
                                    booking.statusId == '5' ? 'success' :
                                    booking.statusId == '7' ? 'danger' : 'danger'}">
                                        ${booking.statusId == '4' ? 'In Progress' :
                                                booking.statusId == '5' ? 'Completed' :
                                                        booking.statusId == '7' ? 'Cancelled' : 'Cancelled'}
                                </span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${booking.statusId == '1'}">
                                <button onclick="startBooking('${booking.bookingNumber}')" class="btn btn-success btn-sm">
                                    Start
                                </button>
                                <button onclick="cancelBooking('${booking.bookingNumber}')" class="btn btn-danger btn-sm">
                                    Cancel
                                </button>
                            </c:when>
                            <c:when test="${booking.statusId == '4'}">
                                <button onclick="finishBooking('${booking.bookingNumber}')"
                                        class="btn btn-primary btn-sm">Finish
                                </button>
                            </c:when>
                        </c:choose>
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
