<jsp:include page="/customer-header.jsp"/>
<style>
    .booking-header {
        background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('/placeholder.svg?height=400&width=1600');
        background-size: cover;
        background-position: center;
        color: white;
        padding: 60px 0;
    }
    .success-icon {
        font-size: 5rem;
        color: #28a745;
        margin-bottom: 1.5rem;
    }
    .booking-details {
        background-color: #f8f9fa;
        border-radius: 10px;
        padding: 20px;
    }
    .detail-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 0.75rem;
        padding-bottom: 0.75rem;
        border-bottom: 1px solid #e9ecef;
    }
    .detail-row:last-child {
        border-bottom: none;
        margin-bottom: 0;
        padding-bottom: 0;
    }
    .detail-label {
        font-weight: 500;
        color: #6c757d;
    }
    .detail-value {
        font-weight: 600;
        text-align: right;
    }
    .car-image-container {
        height: 180px;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1rem;
    }
    .car-image-container img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 8px;
    }
    .timeline {
        position: relative;
        padding-left: 30px;
        margin-top: 20px;
    }
    .timeline::before {
        content: '';
        position: absolute;
        left: 15px;
        top: 0;
        bottom: 0;
        width: 2px;
        background: #ffc107;
    }
    .timeline-item {
        position: relative;
        padding-bottom: 25px;
    }
    .timeline-item:last-child {
        padding-bottom: 0;
    }
    .timeline-item::before {
        content: '';
        position: absolute;
        left: -30px;
        top: 0;
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: #ffc107;
        border: 2px solid #fff;
    }
    .timeline-item-content {
        padding-left: 10px;
    }
    .timeline-item-title {
        font-weight: 600;
        margin-bottom: 5px;
    }
    .timeline-item-subtitle {
        color: #6c757d;
        font-size: 0.9rem;
    }
    .qr-code {
        max-width: 150px;
        margin: 0 auto;
    }
</style>

<!-- Payment Success Section -->
<section class="py-5 bg-light" id="paymentSuccessSection">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-success text-white py-3">
                        <h4 class="mb-0"><i class="fas fa-check-circle me-2"></i>Payment Successful</h4>
                    </div>
                    <div class="card-body p-4">
                        <!-- Success Message -->
                        <div class="text-center mb-4">
                            <i class="fas fa-check-circle success-icon"></i>
                            <h3 class="mb-2">Thank You for Your Booking!</h3>
                            <p class="lead text-muted">Your payment has been processed successfully.</p>
                            <div class="alert alert-success d-inline-block">
                                <strong>Booking ID:</strong> <span id="bookingId">${booking.bookingNumber}</span>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-between">
                            <a href="/customer-booking/my-booking" class="btn btn-outline-secondary">
                                <i class="fas fa-list me-2"></i>View All Bookings
                            </a>
                            <a href="/home.jsp" class="btn btn-warning">
                                <i class="fas fa-home me-2"></i>Back to Home
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


<jsp:include page="/customer-footer.jsp"/>

<script>
    // You can add any JavaScript functionality here if needed
    document.addEventListener('DOMContentLoaded', function() {
        // Example: Add confetti effect for payment success
        // This is just a placeholder - you would need to include a confetti library
        if (typeof confetti !== 'undefined') {
            confetti({
                particleCount: 100,
                spread: 70,
                origin: { y: 0.6 }
            });
        }

        // Example: Set a timer to check driver assignment status
        // In a real implementation, you might use WebSockets or polling
        setInterval(checkDriverStatus, 30000); // Check every 30 seconds
    });

    function checkDriverStatus() {
        // This is a placeholder function
        // In a real implementation, you would make an AJAX call to check if a driver has been assigned
        const bookingId = document.getElementById('bookingId').textContent;

        // Example AJAX call (commented out)
        /*
        $.ajax({
          url: '/customer-booking/check-driver-status',
          type: 'GET',
          data: { bookingId: bookingId },
          success: function(response) {
            if (response.driverAssigned) {
              // Update the driver information section
              updateDriverInfo(response.driverInfo);
            }
          }
        });
        */
    }

    function updateDriverInfo(driverInfo) {
        // This is a placeholder function to update driver information when assigned
        // In a real implementation, you would update the DOM with driver details
    }
</script>