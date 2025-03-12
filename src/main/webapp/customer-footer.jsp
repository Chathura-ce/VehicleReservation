
<!-- About Section -->
<section class="py-5 bg-light" id="about">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-lg-6 mb-4 mb-lg-0">
        <img src="/assets/img/aboutus.jpg" alt="About Mega City Cab" class="img-fluid rounded shadow">
      </div>
      <div class="col-lg-6">
        <h2 class="fw-bold mb-4">About Mega City Cab</h2>
        <p class="lead">Serving Colombo City with pride since 2010</p>
        <p>Mega City Cab is a premier cab service in Colombo City, trusted by thousands of customers monthly. We pride ourselves on providing reliable, safe, and comfortable transportation services throughout the city.</p>
        <p>Our fleet of well-maintained vehicles and professional drivers ensure that you reach your destination on time, every time. Whether you're a local resident or a visitor to our beautiful city, Mega City Cab is your trusted partner for all your transportation needs.</p>
        <div class="d-flex mt-4">
          <div class="me-4">
            <h4 class="fw-bold text-warning">5000+</h4>
            <p>Monthly Customers</p>
          </div>
          <div class="me-4">
            <h4 class="fw-bold text-warning">100+</h4>
            <p>Professional Drivers</p>
          </div>
          <div>
            <h4 class="fw-bold text-warning">98%</h4>
            <p>Satisfaction Rate</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Contact Section -->
<section style="display: none" class="py-5 bg-dark text-white" id="contact">
  <div class="container">
    <div class="row">
      <div class="col-lg-5 mb-4 mb-lg-0">
        <h2 class="fw-bold mb-4">Contact Us</h2>
        <p>Have questions or need assistance? Reach out to our customer service team.</p>
        <div class="d-flex align-items-center mb-3">
          <i class="fas fa-map-marker-alt me-3 text-warning"></i>
          <p class="mb-0">123 Main Street, Colombo, Sri Lanka</p>
        </div>
        <div class="d-flex align-items-center mb-3">
          <i class="fas fa-phone me-3 text-warning"></i>
          <p class="mb-0">+94 11 234 5678</p>
        </div>
        <div class="d-flex align-items-center mb-3">
          <i class="fas fa-envelope me-3 text-warning"></i>
          <p class="mb-0">info@megacitycab.com</p>
        </div>
        <div class="mt-4">
          <a href="#" class="text-white me-3"><i class="fab fa-facebook-f fa-lg"></i></a>
          <a href="#" class="text-white me-3"><i class="fab fa-twitter fa-lg"></i></a>
          <a href="#" class="text-white me-3"><i class="fab fa-instagram fa-lg"></i></a>
          <a href="#" class="text-white"><i class="fab fa-whatsapp fa-lg"></i></a>
        </div>
      </div>
      <div class="col-lg-7">
        <div class="card bg-dark border-secondary">
          <div class="card-body">
            <h4 class="mb-4">Send us a message</h4>
            <form>
              <div class="row g-3">
                <div class="col-md-6">
                  <input type="text" class="form-control bg-dark text-white border-secondary" placeholder="Your Name">
                </div>
                <div class="col-md-6">
                  <input type="email" class="form-control bg-dark text-white border-secondary" placeholder="Your Email">
                </div>
                <div class="col-12">
                  <input type="text" class="form-control bg-dark text-white border-secondary" placeholder="Subject">
                </div>
                <div class="col-12">
                  <textarea class="form-control bg-dark text-white border-secondary" rows="4" placeholder="Your Message"></textarea>
                </div>
                <div class="col-12">
                  <button type="submit" class="btn btn-warning">Send Message</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white-50 py-4">
  <div class="container">
    <hr class="my-4 bg-secondary">
    <div class="row">
      <div class="col-md-6 text-center text-md-start">
        <p class="mb-0">&copy; 2025 Mega City Cab. All rights reserved.</p>
      </div>
      <div class="col-md-6 text-center text-md-end">
        <a href="#" class="text-white-50 me-3">Privacy Policy</a>
        <a href="#" class="text-white-50 me-3">Terms of Service</a>
        <a href="#" class="text-white-50">FAQ</a>
      </div>
    </div>
  </div>
</footer>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.blockUI.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
<%
  // Remove the attribute so it doesn't persist
  session.removeAttribute("errorMessage");
  session.removeAttribute("successMessage");
%>