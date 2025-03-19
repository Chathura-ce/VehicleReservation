<jsp:include page="/customer-header.jsp"/>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    .booking-header {
        background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('/placeholder.svg?height=400&width=1600');
        background-size: cover;
        background-position: center;
        color: white;
        padding: 60px 0;
    }

    .car-card {
        transition: all 0.3s;
        cursor: pointer;
        border: 2px solid transparent;
    }

    .car-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }

    .car-card.selected {
        border-color: #ffc107;
        background-color: rgba(255, 193, 7, 0.1);
    }

    .filter-section {
        background-color: #f8f9fa;
        border-radius: 10px;
        padding: 20px;
    }

    .car-info-tag {
        display: inline-block;
        padding: 4px 10px;
        margin-right: 5px;
        margin-bottom: 5px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
    }

    .car-type-tag {
        background-color: #e9f5ff;
        color: #0d6efd;
    }

    .car-model-tag {
        background-color: #f0f8ff;
        color: #0dcaf0;
    }

    .car-capacity-tag {
        background-color: #f0fff0;
        color: #198754;
    }

    .car-price-tag {
        background-color: #fff8e6;
        color: #fd7e14;
    }

    .car-info-section {
        display: flex;
        flex-wrap: wrap;
        margin-bottom: 10px;
    }

    .car-image-container {
        height: 180px;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .car-image-container img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .autocomplete-items {
        position: absolute;
        border: 1px solid #ddd;
        border-top: none;
        z-index: 99;
        top: 100%;
        left: 0;
        right: 0;
        border-radius: 0 0 4px 4px;
        max-height: 200px;
        overflow-y: auto;
        background-color: #fff;
    }

    .autocomplete-items div {
        padding: 10px;
        cursor: pointer;
    }

    .autocomplete-items div:hover {
        background-color: #e9e9e9;
    }

    .autocomplete-active {
        background-color: #4CAF50 !important;
        color: white;
    }
</style>
<section class="py-5 bg-light" id="bookingSection">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow">
                    <div class="card-header bg-warning text-dark py-2">
                        <h4 class="mb-0">My Bookings</h4>
                    </div>
                    <div class="card-body p-3">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead class="thead-dark">
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Car</th>
                                    <th>Date</th>
                                    <th>Total Price</th>
                                    <th>Status</th>
                                    <th>Payment Status</th>
                                    <th>View</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${bookings}" var="booking">
                                    <tr>
                                        <td>${booking.bookingNumber}</td>
                                        <td>${booking.car.type.typeName} ${booking.car.model.modelName}</td>
                                        <td>${booking.pickupDate} ${booking.formattedTime}</td>
                                        <td>${booking.totalFare} Rs</td>
                                        <td>${booking.status.statusName}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${booking.isPaid == 0}">
                                                    <button onclick="openPayment('${booking.bookingNumber}');"
                                                            data-booking-number="${booking.bookingNumber}"
                                                            class="btn btn-success btn-sm pay-btn">Pay Now
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success">Paid</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button onclick="printBill('${booking.bookingNumber}');"
                                                    class="btn btn-primary btn-sm">View
                                            </button>
                                            <button onclick="cancelBooking('${booking.bookingNumber}');"
                                                    class="btn btn-danger btn-sm">Cancel
                                            </button>
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
    </div>
</section>

<jsp:include page="/customer-footer.jsp"/>

<script src="https://js.stripe.com/v3/"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
    const stripe = Stripe('pk_test_51R2xBMHBoMeUyf28bznECFFunlTYFzYEmJ7enSGhUuxrBe9b5TLq7Pj9QED3sWitNCzFdycdxC4SZukmPj8l0eQl00fVrOCA5K'); // Your Publishable Key


    $(function () {
        // $('#about').hide();
        // $('#contact').hide();

    })

    function openPayment(bookingNumber) {
        $.ajax({
            url: '/create-checkout-session', // The endpoint to create a checkout session
            method: 'POST',                  // HTTP method
            dataType: 'json',              // Expect JSON response
            data: {
                bookingNumber: bookingNumber
            }
        }).done(function (session) {
            // Redirect to Stripe Checkout using the session ID
            stripe.redirectToCheckout({sessionId: session.id})
                .then(function (result) {
                    // Handle any errors from redirectToCheckout
                    if (result.error) {
                        alert(result.error.message);
                    }
                });
        })
            .fail(function (jqXHR, textStatus, errorThrown) {
                // Handle any errors that occurred during the AJAX request
                console.error('Error creating checkout session:', textStatus, errorThrown);
                alert('An error occurred while creating the checkout session.');
            });
    }

    function printBill(bookingNumber) {
        // Construct the URL for the new page with the booking number as a query parameter
        let url = '/bill?bookingNumber=' + bookingNumber;

        // Open the new page in a new tab
        window.open(url, '_blank');
    }

    function cancelBooking(bookingNumber) {
        Swal.fire({
            title: 'Are you sure?',
            text: 'Do you really want to cancel booking number ' + bookingNumber + '?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, cancel it!',
            cancelButtonText: 'No, keep it'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/customer-booking/cancel-booking', // The endpoint to cancel a booking
                    method: 'POST',         // HTTP method
                    data: {
                        bookingNumber: bookingNumber
                    },
                    success: function (response) {
                        if (response.status === 'success') {
                            Swal.fire({
                                title: 'Booking Canceled',
                                text: 'Your booking has been canceled successfully.',
                                icon: 'success'
                            }).then(() => {
                                location.reload();
                            });
                        } else {
                            Swal.fire({
                                title: 'Error',
                                text: response.message,
                                icon: 'error'
                            });
                        }
                    }
                }) ;
            }
        });
    }

</script>