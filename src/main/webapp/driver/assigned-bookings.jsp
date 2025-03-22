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
                        <c:choose>
                            <c:when test="${booking.statusId == '0'}">
                                <span class="badge bg-warning">Pending Payment</span>
                            </c:when>
                            <c:when test="${booking.statusId == '1'}">
                                <span class="badge bg-primary">Waiting Start</span>
                            </c:when>
                            <c:when test="${booking.statusId == '4'}">
                                <span class="badge bg-info">In Progress</span>
                            </c:when>
                            <c:when test="${booking.statusId == '5'}">
                                <span class="badge bg-success">Completed</span>
                            </c:when>
                            <c:when test="${booking.statusId == '6'}">
                                <span class="badge bg-danger">Canceled by System</span>
                            </c:when>
                            <c:when test="${booking.statusId == '7'}">
                                <span class="badge bg-danger">Driver Canceled</span>
                            </c:when>
                            <c:when test="${booking.statusId == '9'}">
                                <span class="badge bg-danger">Customer Canceled</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">Unknown</span>
                            </c:otherwise>
                        </c:choose>


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

    function startBooking(bookingNumber) {
        Swal.fire({
            title: "Are you sure?",
            text: "Do you want to start this booking?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Yes, start it!"
        }).then((result) => {
            if (result.isConfirmed) {
                $.post("${pageContext.request.contextPath}" + "/driver-dashboard/start-booking",
                    { bookingNumber: bookingNumber })
                    .done(function (data) {
                        if (data.success) {
                            Swal.fire("Started!", "Booking has been started.", "success")
                                .then(() => location.reload());
                        } else {
                            Swal.fire("Error!", "Failed to start booking: " + data.message, "error");
                        }
                    })
                    .fail(function () {
                        Swal.fire("Error!", "An error occurred while starting the booking.", "error");
                    });
            }
        });
    }

    function cancelBooking(bookingNumber) {
        Swal.fire({
            title: "Are you sure?",
            text: "Do you want to cancel this booking?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Yes, cancel it!"
        }).then((result) => {
            if (result.isConfirmed) {
                $.post("${pageContext.request.contextPath}" + "/driver-dashboard/cancel-booking",
                    { bookingNumber: bookingNumber })
                    .done(function (data) {
                        if (data.success) {
                            Swal.fire("Cancelled!", "Booking has been cancelled.", "success")
                                .then(() => location.reload());
                        } else {
                            Swal.fire("Error!", "Failed to cancel booking: " + data.message, "error");
                        }
                    })
                    .fail(function () {
                        Swal.fire("Error!", "An error occurred while canceling the booking.", "error");
                    });
            }
        });
    }

    function finishBooking(bookingNumber) {
        Swal.fire({
            title: "Are you sure?",
            text: "Do you want to finish this booking?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Yes, finish it!"
        }).then((result) => {
            if (result.isConfirmed) {
                $.post("${pageContext.request.contextPath}" + "/driver-dashboard/finish-booking",
                    { bookingNumber: bookingNumber })
                    .done(function (data) {
                        if (data.success) {
                            Swal.fire("Finished!", "Booking has been finished.", "success")
                                .then(() => location.reload());
                        } else {
                            Swal.fire("Error!", "Failed to finish booking: " + data.message, "error");
                        }
                    })
                    .fail(function () {
                        Swal.fire("Error!", "An error occurred while finishing the booking.", "error");
                    });
            }
        });
    }


</script>
