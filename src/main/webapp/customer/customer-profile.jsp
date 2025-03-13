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
<section class="py-5 bg-light" id="profileSection">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-8">
        <div class="card shadow-lg border-0 rounded-lg overflow-hidden">
          <div class="card-header bg-warning text-dark py-3 d-flex align-items-center">
            <i class="fas fa-user-circle fa-2x me-3"></i>
            <h4 class="mb-0 fw-bold">My Profile</h4>
          </div>
          <div class="card-body bg-white p-4">
            <div class="row g-4">
              <div class="col-md-6">
                <div class="profile-field p-3 rounded bg-light">
                  <label class="form-label text-muted mb-1"><i class="fas fa-user me-2"></i>Full Name</label>
                  <p class="form-control-plaintext fs-5 fw-medium mb-0"><c:out value="${customer.getUser().getFullName()}"/></p>
                </div>
              </div>
              <div class="col-md-6">
                <div class="profile-field p-3 rounded bg-light">
                  <label class="form-label text-muted mb-1"><i class="fas fa-envelope me-2"></i>Email</label>
                  <p class="form-control-plaintext fs-5 fw-medium mb-0"><c:out value="${customer.getUser().getEmail()}"/></p>
                </div>
              </div>
              <div class="col-md-6">
                <div class="profile-field p-3 rounded bg-light">
                  <label class="form-label text-muted mb-1"><i class="fas fa-phone me-2"></i>Phone Number</label>
                  <p class="form-control-plaintext fs-5 fw-medium mb-0"><c:out value="${user.phone}" default="Not provided"/></p>
                </div>
              </div>
              <div class="col-md-6">
                <div class="profile-field p-3 rounded bg-light">
                  <label class="form-label text-muted mb-1"><i class="fas fa-id-card me-2"></i>NIC Number</label>
                  <p class="form-control-plaintext fs-5 fw-medium mb-0"><c:out value="${user.nic}" default="Not provided"/></p>
                </div>
              </div>
              <div class="col-12">
                <div class="profile-field p-3 rounded bg-light">
                  <label class="form-label text-muted mb-1"><i class="fas fa-map-marker-alt me-2"></i>Address</label>
                  <p class="form-control-plaintext fs-5 fw-medium mb-0"><c:out value="${customer.address}" default="Not provided"/></p>
                </div>
              </div>

              <div class="col-12 mt-4 text-center" style="display: none">
                <button class="btn btn-warning px-4 py-2 me-2">
                  <i class="fas fa-edit me-2"></i>Edit Profile
                </button>
                <button class="btn btn-outline-secondary px-4 py-2">
                  <i class="fas fa-key me-2"></i>Change Password
                </button>
              </div>
            </div>
          </div>
          <div class="card-footer bg-light py-3 text-center">
            <small class="text-muted">Member since: January 2023</small>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<jsp:include page="/customer-footer.jsp"/>
 