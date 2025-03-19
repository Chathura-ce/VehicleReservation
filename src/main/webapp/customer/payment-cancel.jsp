<jsp:include page="/customer-header.jsp"/>
<style>
    .booking-header {
        background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('/placeholder.svg?height=400&width=1600');
        background-size: cover;
        background-position: center;
        color: white;
        padding: 60px 0;
    }
    .cancel-icon {
        font-size: 5rem;
        color: #dc3545;
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
    .reason-card {
        border-left: 4px solid #dc3545;
        background-color: #f8f9fa;
        padding: 15px;
        margin-bottom: 10px;
        border-radius: 4px;
    }
    .reason-card h6 {
        color: #dc3545;
        margin-bottom: 5px;
    }
    .reason-card p {
        margin-bottom: 0;
        color: #6c757d;
        font-size: 0.9rem;
    }
    .retry-section {
        background-color: #fff8e6;
        border-radius: 10px;
        padding: 20px;
        border: 1px solid #ffeeba;
    }
</style>

<!-- Payment Canceled Section -->
<section class="py-5 bg-light" id="paymentCancelSection">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-danger text-white py-3">
                        <h4 class="mb-0"><i class="fas fa-times-circle me-2"></i>Payment Canceled</h4>
                    </div>
                    <div class="card-body p-4">
                        <!-- Cancel Message -->
                        <div class="text-center mb-4">
                            <i class="fas fa-times-circle cancel-icon"></i>
                            <h3 class="mb-2">Payment Not Completed</h3>
                            <p class="lead text-muted">Your payment process was canceled or did not complete successfully.</p>
                            <div class="alert alert-secondary d-inline-block">
                                <strong>Booking ID:</strong> <span id="bookingId">${booking.bookingNumber}</span>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-between">
                            <a href="/customer-booking/my-booking" class="btn btn-outline-danger">
                                <i class="fas fa-times me-2"></i>Cancel Booking
                            </a>
                            <a href="/home.jsp" class="btn btn-primary">
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
    document.addEventListener('DOMContentLoaded', function() {
        // You can add any JavaScript functionality here if needed

        // Example: Track cancellation reason if provided
        const urlParams = new URLSearchParams(window.location.search);
        const cancelReason = urlParams.get('reason');

        if (cancelReason) {
            // You could highlight a specific reason based on the URL parameter
            highlightCancelReason(cancelReason);
        }

        // Example: Set a timer for booking expiration
        startBookingExpirationTimer();
    });

    function highlightCancelReason(reason) {
        // This is a placeholder function to highlight a specific cancellation reason
        const reasonCards = document.querySelectorAll('.reason-card');

        reasonCards.forEach(card => {
            const cardTitle = card.querySelector('h6').textContent.toLowerCase();

            if (cardTitle.includes(reason.toLowerCase())) {
                card.style.backgroundColor = '#fff8e6';
                card.style.borderLeftColor = '#ffc107';
            }
        });
    }

    function startBookingExpirationTimer() {
        // This is a placeholder function to show a countdown until the booking expires
        // In a real implementation, you would get the expiration time from the server

        // Example: Booking expires in 30 minutes
        let minutesLeft = 30;

        // Create timer element if it doesn't exist
        if (!document.getElementById('expirationTimer')) {
            const timerDiv = document.createElement('div');
            timerDiv.id = 'expirationTimer';
            timerDiv.className = 'alert alert-warning mt-3';
            timerDiv.innerHTML = `<i class="fas fa-clock me-2"></i>This booking will expire in <strong>${minutesLeft} minutes</strong>`;

            // Insert after the booking details
            const bookingDetails = document.querySelector('.booking-details');
            bookingDetails.parentNode.insertBefore(timerDiv, bookingDetails.nextSibling);
        }

        // Update timer every minute
        const timerInterval = setInterval(() => {
            minutesLeft--;

            if (minutesLeft <= 0) {
                clearInterval(timerInterval);
                document.getElementById('expirationTimer').innerHTML = `<i class="fas fa-exclamation-circle me-2"></i>This booking has <strong>expired</strong>`;
                document.getElementById('expirationTimer').className = 'alert alert-danger mt-3';

                // Disable retry buttons
                document.querySelectorAll('.retry-section .btn').forEach(btn => {
                    btn.classList.add('disabled');
                });
            } else {
                document.getElementById('expirationTimer').innerHTML = `<i class="fas fa-clock me-2"></i>This booking will expire in <strong>${minutesLeft} minutes</strong>`;
            }
        }, 60000); // Update every minute
    }
</script>