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
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
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
      <div class="col-lg-8">
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
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach items="${bookings}" var="booking">
                    <tr>
                      <td>${booking.bookingNumber}</td>
                      <td>${booking.car.type.typeName} ${booking.car.model.modelName}</td>
                      <td>${booking.formattedDate}</td>
                      <td>${booking.totalFare} Rs</td>
                      <td>${booking.statusLabel}</td>
                      <td>
                        <button onclick="printBill('${booking.bookingNumber}');"  class="btn btn-primary btn-sm">Details</button>
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


<script>
  $(function () {
    // $('#about').hide();
    // $('#contact').hide();

  })

  function printBill(bookingNumber) {
    // Construct the URL for the new page with the booking number as a query parameter
    let url = '/bill?bookingNumber=' + bookingNumber;

    // Open the new page in a new tab
    window.open(url, '_blank');
  }

</script>