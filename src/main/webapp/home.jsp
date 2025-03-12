<jsp:include page="/customer-header.jsp"/>
<!-- Hero Section -->
<section class="hero-section">
    <div class="container text-center">
        <h1 class="display-3 fw-bold mb-4">Your Reliable Cab Service in Colombo</h1>
        <p class="lead mb-5">Thousands of satisfied customers choose Mega City Cab for safe, comfortable, and affordable rides.</p>
        <a href="#book" class="btn btn-warning btn-lg px-5 py-3 fw-bold">Book Your Ride Now</a>
    </div>
</section>

<!-- Search Car Section -->
<section class="py-5 bg-light" id="book">
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
                        <div class="row g-4" id="carListing"></div>

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

<jsp:include page="/customer-footer.jsp"/>

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
                        var image = baseUrl + "/uploads/car_images/"+car.carId+".jpg";
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
                            '                        <div class="price-tag">'+car.priceForKm+' Rs<span class="text-muted" style="font-size: 0.8rem;">/Km</span></div>'+
                            '                        <a href="customer-booking/book-car?carId='+car.carId+'" class="btn btn-warning">Book</a>'+
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