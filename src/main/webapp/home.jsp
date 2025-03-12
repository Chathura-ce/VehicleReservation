<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab - Your Reliable Cab Service in Colombo</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('/assets/img/1600x800hero.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #ffc107;
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
        .car-specs {
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 10px;
        }
        .car-spec-item {
            display: flex;
            align-items: center;
            margin-right: 15px;
            margin-bottom: 8px;
        }
        .car-spec-icon {
            width: 20px;
            text-align: center;
            margin-right: 5px;
            color: #6c757d;
        }
        .price-tag {
            font-size: 1.25rem;
            font-weight: 600;
            color: #212529;
        }
        .search-result-count {
            font-size: 0.9rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="index.html">
            <i class="fas fa-taxi me-2"></i>
            Mega City Cab
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="index.html">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#services">Services</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about">About Us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link btn btn-warning text-dark ms-lg-3 px-4" href="booking.html">Book Now</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container text-center">
        <h1 class="display-3 fw-bold mb-4">Your Reliable Cab Service in Colombo</h1>
        <p class="lead mb-5">Thousands of satisfied customers choose Mega City Cab for safe, comfortable, and affordable rides.</p>
        <a href="booking.html" class="btn btn-warning btn-lg px-5 py-3 fw-bold">Book Your Ride Now</a>
    </div>
</section>

<!-- Search Car Section -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow">
                    <div class="card-body p-4">
                        <h3 class="card-title text-center mb-4">Find Your Perfect Ride</h3>
                        <form action="booking.html" method="get">
                            <div class="row g-3">
                                <div class="col-md-5">
                                    <label for="carType" class="form-label">Car Type</label>
                                    <select onchange="getCarModels();" class="form-select" id="carType" name="carType">
                                        <option value="">All Car Types</option>
                                    </select>
                                </div>
                                <div class="col-md-5">
                                    <label for="carModel" class="form-label">Car Model</label>
                                    <select class="form-select" id="carModel" name="carModel">
                                        <option value="">All Car Models</option>
                                    </select>
                                </div>
                                <div class="col-md-2 d-flex align-items-end">
                                    <button onclick="searchCars(event);" type="button" class="btn btn-warning w-100">Search</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search Results Section (This is the new section) -->
        <div class="row justify-content-center mt-4">
            <div class="col-lg-12">
                <div class="card shadow">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h4 class="mb-1">Search Results</h4>
                                <p class="search-result-count mb-0"><span id="resultCount">4</span> cars found</p>
                            </div>
                            <div class="d-flex align-items-center">
                                <label for="sortBy" class="me-2">Sort by:</label>
                                <select onchange="searchCars(null)" class="form-select form-select-sm" id="sortBy" style="width: 150px;">
                                    <option value="price-asc">Price: Low to High</option>
                                    <option value="price-desc">Price: High to Low</option>
                                </select>
                            </div>
                        </div>

                        <!-- Car Cards -->
                        <div class="row g-4" id="carListing">
                            <!-- Car 1 -->
                            <div class="col-md-6" data-type="sedan" data-model="toyota" data-passengers="4" data-price="10">
                                <div class="card car-card h-100">
                                    <div class="row g-0">
                                        <div class="col-md-5">
                                            <img src="/placeholder.svg?height=200&width=200" class="img-fluid rounded-start h-100" style="object-fit: cover;" alt="Toyota Corolla">
                                        </div>
                                        <div class="col-md-7">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <h5 class="card-title mb-1">Toyota Corolla</h5>
                                                    <div class="mb-2">
                                                        <i class="fas fa-star text-warning"></i>
                                                        <i class="fas fa-star text-warning"></i>
                                                        <i class="fas fa-star text-warning"></i>
                                                        <i class="fas fa-star text-warning"></i>
                                                        <i class="fas fa-star-half-alt text-warning"></i>
                                                        <small class="text-muted ms-1">(4.5)</small>
                                                    </div>
                                                </div>

                                                <div class="car-specs">
                                                    <div class="car-spec-item">
                                                        <div class="car-spec-icon">
                                                            <i class="fas fa-car"></i>
                                                        </div>
                                                        <span>Sedan</span>
                                                    </div>
                                                    <div class="car-spec-item">
                                                        <div class="car-spec-icon">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <span>4 Seats</span>
                                                    </div>
                                                    <div class="car-spec-item">
                                                        <div class="car-spec-icon">
                                                            <i class="fas fa-suitcase"></i>
                                                        </div>
                                                        <span>2 Bags</span>
                                                    </div>
                                                    <div class="car-spec-item">
                                                        <div class="car-spec-icon">
                                                            <i class="fas fa-snowflake"></i>
                                                        </div>
                                                        <span>AC</span>
                                                    </div>
                                                </div>

                                                <div class="d-flex justify-content-between align-items-center mt-2">
                                                    <div class="price-tag">$10<span class="text-muted" style="font-size: 0.8rem;">/hour</span></div>
                                                    <a href="booking.html?car=1" class="btn btn-warning">Select</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold">Why Choose Mega City Cab?</h2>
            <p class="lead text-muted">We provide the best cab service in Colombo</p>
        </div>
        <div class="row g-4">
            <div class="col-md-3 col-6">
                <div class="text-center">
                    <i class="fas fa-car feature-icon"></i>
                    <h5>Wide Selection</h5>
                    <p class="text-muted">Choose from various car types and models</p>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="text-center">
                    <i class="fas fa-clock feature-icon"></i>
                    <h5>24/7 Service</h5>
                    <p class="text-muted">Available anytime</p>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="text-center">
                    <i class="fas fa-shield-alt feature-icon"></i>
                    <h5>Safe Rides</h5>
                    <p class="text-muted">Verified drivers</p>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="text-center">
                    <i class="fas fa-tags feature-icon"></i>
                    <h5>Best Rates</h5>
                    <p class="text-muted">Competitive pricing</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- About Section -->
<section class="py-5 bg-light" id="about">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-4 mb-lg-0">
                <img src="/placeholder.svg?height=400&width=600" alt="About Mega City Cab" class="img-fluid rounded shadow">
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
<section class="py-5 bg-dark text-white" id="contact">
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
        <div class="row">
            <div class="col-md-4 mb-4 mb-md-0">
                <h5 class="text-white mb-3">Mega City Cab</h5>
                <p>Your trusted cab service in Colombo City. Safe, reliable, and affordable transportation for all your needs.</p>
            </div>
            <div class="col-md-2 mb-4 mb-md-0">
                <h5 class="text-white mb-3">Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="index.html" class="text-white-50">Home</a></li>
                    <li><a href="#services" class="text-white-50">Services</a></li>
                    <li><a href="#about" class="text-white-50">About Us</a></li>
                    <li><a href="#contact" class="text-white-50">Contact</a></li>
                </ul>
            </div>
            <div class="col-md-2 mb-4 mb-md-0">
                <h5 class="text-white mb-3">Services</h5>
                <ul class="list-unstyled">
                    <li><a href="booking.html" class="text-white-50">Book a Cab</a></li>
                    <li><a href="booking.html" class="text-white-50">Airport Transfer</a></li>
                    <li><a href="booking.html" class="text-white-50">Corporate Service</a></li>
                    <li><a href="booking.html" class="text-white-50">Long Distance</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5 class="text-white mb-3">Download Our App</h5>
                <p>Get the Mega City Cab app for faster bookings and exclusive deals.</p>
                <div class="d-flex">
                    <a href="#" class="me-2"><img src="/placeholder.svg?height=40&width=120" alt="App Store" class="img-fluid"></a>
                    <a href="#"><img src="/placeholder.svg?height=40&width=120" alt="Google Play" class="img-fluid"></a>
                </div>
            </div>
        </div>
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
</body>
</html>

<script>
    var baseUrl = "${pageContext.request.contextPath}";
    $(function (){
        getCarTypes();
        searchCars();
    });

    function searchCars(e) {
       if(e) e.preventDefault();
        $.ajax({
            url: '${pageContext.request.contextPath}/car/searchCars',
            type: 'GET',
            data: {
                carType: $("#carType").val(),
                carModel: $("#carModel").val(),
                sortBy: $("#sortBy").val(),
            },
            dataType: 'json',
            success: function (data) {
                d = data;
                var rows = "";
                if (data && data.length > 0) {
                    $.each(data, function (index, car) {
                        var image = baseUrl + "/images/car-5.jpg";
                        rows += '<div class="col-md-6" data-type="'+car.type.typeName+'" data-model="'+car.model.modelName+'" data-passengers="'+car.seatingCapacity+'" data-price="10">'+
                            '    <div class="card car-card h-100">'+
                            '        <div class="row g-0">'+
                            '            <div class="col-md-5">'+
                            '                <img src="'+image+'" class="img-fluid rounded-start h-100" style="object-fit: cover;" alt="'+car.model.modelName+'">'+
                            '            </div>'+
                            '            <div class="col-md-7">'+
                            '                <div class="card-body">'+
                            '                    <div class="d-flex justify-content-between align-items-start">'+
                            '                        <h5 class="card-title mb-1">'+car.model.modelName+'</h5>'+
                            '                        <div class="mb-2" style="display: none">'+
                            '                            <i class="fas fa-star text-warning"></i>'+
                            '                            <i class="fas fa-star text-warning"></i>'+
                            '                            <i class="fas fa-star text-warning"></i>'+
                            '                            <i class="fas fa-star text-warning"></i>'+
                            '                            <i class="fas fa-star-half-alt text-warning"></i>'+
                            '                            <small class="text-muted ms-1">(4.5)</small>'+
                            '                        </div>'+
                            '                    </div>'+
                            '                    <div class="car-specs">'+
                            '                        <div class="car-spec-item">'+
                            '                            <div class="car-spec-icon">'+
                            '                                <i class="fas fa-car"></i>'+
                            '                            </div>'+
                            '                            <span>'+car.type.typeName+'</span>'+
                            '                        </div>'+
                            '                        <div class="car-spec-item">'+
                            '                            <div class="car-spec-icon">'+
                            '                                <i class="fas fa-user"></i>'+
                            '                            </div>'+
                            '                            <span>'+car.seatingCapacity+' Seats</span>'+
                            '                        </div>'+
                            '                        <div class="car-spec-item" style="display: none">'+
                            '                            <div class="car-spec-icon">'+
                            '                                <i class="fas fa-suitcase"></i>'+
                            '                            </div>'+
                            '                            <span>2 Bags</span>'+
                            '                        </div>'+
                            '                        <div class="car-spec-item" style="display: none">'+
                            '                            <div class="car-spec-icon">'+
                            '                                <i class="fas fa-snowflake"></i>'+
                            '                            </div>'+
                            '                            <span>AC</span>'+
                            '                        </div>'+
                            '                    </div>'+
                            '                    <div class="d-flex justify-content-between align-items-center mt-2">'+
                            '                        <div class="price-tag">'+car.priceForKm+' Rs<span class="text-muted" style="font-size: 0.8rem;">/hour</span></div>'+
                            '                        <a href="customer-booking/book-car?carId='+car.carId+'" class="btn btn-warning">Select</a>'+
                            '                    </div>'+
                            '                </div>'+
                            '            </div>'+
                            '        </div>'+
                            '    </div>'+
                            '</div>';
                        ;
                    });
                } else {
                    rows = "<p class='text-muted'>No cars found matching your criteria.</p>";
                }
                $("#carListing").html(rows);
            },
            error: function () {
                $("#carListing").html("<p class='text-danger'>Error loading car data. Please try again.</p>");
            }
        });
    }


    function getCarTypes() {
        $.ajax({
            url: '${pageContext.request.contextPath}/getCarTypes',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                var options = '<option value="0">All Car Types</option>';
                $.each(data, function (index, carType) {
                    options += '<option value="' + carType.typeId + '">' + carType.typeName + '</option>';
                });
                $("#carType").html(options);
            },
            error: function () {
                $("#carType").html('<option value="0">All Car Types</option>');
            }
        });
    }

    function getCarModels() {
        var typeId = $('#carType').val();
        // Clear the car model dropdown if no car carType is selected
        if (!typeId) {
            $('#carModel').html('<option value="0">All Car Models<option>');
            return;
        }
        $.ajax({
            url: '${pageContext.request.contextPath}/getCarModels', // adjust your context path as needed
            type: 'GET',
            data: {typeId: typeId},
            dataType: 'json',
            success: function (data) {
                var options = '<option value="0">Select a Model</option>';
                if (data && data.length > 0) {
                    $.each(data, function (index, carModel) {
                        options += '<option value="' + carModel.modelId + '">' + carModel.modelName + '</option>';
                    });
                } else {
                    options += '<option value="0">All Car Models</option>';
                }
                $('#carModel').html(options);
            },
            error: function () {
                $('#carModel').html('<option value="0">All Car Models</option>');
            }
        });

    }
</script>