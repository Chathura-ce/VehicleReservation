<%@ include file="../header.jsp" %>
<!-- FilePond CSS -->
<link href="https://unpkg.com/filepond@4.30.4/dist/filepond.css" rel="stylesheet">
<!-- FilePond Image Preview -->
<link href="https://unpkg.com/filepond-plugin-image-preview/dist/filepond-plugin-image-preview.css" rel="stylesheet">
<div class="row">
    <div class="col-sm-6">
        <h3 class="mb-0">Car</h3>
    </div>
    <div class="col-sm-6">
        <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item">Car</li>
            <li class="breadcrumb-item active" aria-current="page">Add Car</li>
        </ol>
    </div>
</div>

<div class="row d-flex justify-content-center mt-5">
    <div class="col-sm-8">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Add New Car</h3>
            </div>
            <div class="card-body">

                <!-- Display Validation Errors -->
                <%
                    String errorMessage = (String) session.getAttribute("errorMessage");
                    if (errorMessage != null && !errorMessage.trim().isEmpty()) {
                %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= errorMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                        session.removeAttribute("errorMessage");
                    }
                %>

                <!-- Display Success Message -->
                <%
                    String successMessage = (String) session.getAttribute("successMessage");
                    if (successMessage != null && !successMessage.trim().isEmpty()) {
                %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= successMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                        session.removeAttribute("successMessage");
                    }
                %>

                <form action="${pageContext.request.contextPath}/add-car" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <!-- Car ID -->
                        <div class="col-md-6">
                            <label for="carId">Car ID</label>
                            <div class="input-group mb-3">
                                <input readonly type="text" class="form-control" id="carId" name="carId"
                                       value="${carId != null ? carId : ''}">
                                <div class="input-group-text">
                                    <span class="bi bi-car-front"></span>
                                </div>
                            </div>
                        </div>


                        <!-- Car Type -->
                        <div class="col-md-6">
                            <label for="type">Car Type</label>
                            <div class="input-group mb-3">
                                <select onchange="getCarModels()" class="form-control" id="type" name="type">
                                    <option value="">Select a Type</option>
                                    <c:forEach var="type" items="${carTypes}">
                                        <option value="${type.typeId}">
                                                ${type.typeName}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="input-group-text">
                                    <span class="bi bi-car"></span>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <!-- Car Model -->
                        <div class="col-md-6">
                            <label for="model">Car Model</label>
                            <div class="input-group mb-3">
                                <select class="form-control" id="model" name="model">
                                    <option value="">Select a Model</option>
                                </select>
                                <div class="input-group-text">
                                    <span class="bi bi-car-front-fill"></span>
                                </div>
                            </div>
                        </div>

                        <!-- Registration Number -->
                        <div class="col-md-6">
                            <label for="regNumber">Registration Number</label>
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" id="regNumber" name="regNumber"
                                       value="${regNumber != null ? regNumber : ''}" required>
                                <div class="input-group-text">
                                    <span class="bi bi-file-earmark-text"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Seating Capacity -->
                        <div class="col-md-6">
                            <label for="seatingCapacity">Seating Capacity</label>
                            <div class="input-group mb-3">
                                <input type="number" class="form-control" id="seatingCapacity" name="seatingCapacity"
                                       value="${seatingCapacity != null ? seatingCapacity : ''}" required>
                                <div class="input-group-text">
                                    <span class="bi bi-people"></span>
                                </div>
                            </div>
                        </div>

                        <!-- Car Availability -->
                        <div class="col-md-6">
                            <label for="available">Is the Car Available?</label>
                            <div class="input-group mb-3">
                                <select class="form-control" id="available" name="available" required>
                                    <option value="">Select Availability</option>
                                    <option value="1" ${available == '1' ? 'selected' : ''}>Yes</option>
                                    <option value="0" ${available == '0' ? 'selected' : ''}>No</option>
                                </select>
                                <div class="input-group-text">
                                    <span class="bi bi-check-circle"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Assigned Driver Dropdown -->
                        <div class="col-md-6">
                            <label for="driverId">Assign Driver
                            </label>
                            <div class="input-group mb-3">
                                <select class="form-control" id="driverId" name="driverId">
                                    <option value="">Select a Driver</option>
                                    <c:forEach var="driver" items="${availableDrivers}">
                                        <option value="${driver.driverId}">
                                                ${driver.user.fullName}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="input-group-text">
                                    <span class="bi bi-person-badge"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--**********--%>
                    <!-- Image Upload Section -->
                    <div class="row mb-3" style="display: none">
                        <div class="col-12">
                            <label class="form-label">Car Images</label>
                            <input type="file"
                                   class="filepond"
                                   name="carImages"
                                   multiple
                                   data-max-file-size="5MB"
                                   accept="image/png, image/jpeg">
                        </div>
                    </div>
                    <input type="hidden" id="uploadedImages" name="imagePaths">

                    <%--**********--%>


                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary">Add Car</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<%@ include file="../footer.jsp" %>
<!-- FilePond JS -->
<script src="https://unpkg.com/filepond@4.30.4/dist/filepond.js"></script>
<script src="https://unpkg.com/filepond-plugin-image-preview/dist/filepond-plugin-image-preview.js"></script>
<script src="https://unpkg.com/filepond-plugin-file-validate-type/dist/filepond-plugin-file-validate-type.js"></script>

<script>
    function getCarModels() {
        var typeId = $('#type').val();
        // Clear the car model dropdown if no car type is selected
        if (!typeId) {
            $('#model').html('<option value="">Select a Model<option>');
            return;
        }
        $.ajax({
            url: '${pageContext.request.contextPath}/getCarModels', // adjust your context path as needed
            type: 'GET',
            data: {typeId: typeId},
            dataType: 'json',
            success: function (data) {
                var options = '<option value="">Select a Model</option>';
                if (data && data.length > 0) {
                    $.each(data, function (index, carModel) {
                        options += '<option value="' + carModel.modelId + '">' + carModel.modelName + '</option>';
                    });
                } else {
                    options += '<option value="">No models available</option>';
                }
                $('#model').html(options);
            },
            error: function () {
                $('#model').html('<option value="">Error loading models</option>');
            }
        });

    }

    // Register plugins
    FilePond.registerPlugin(
        FilePondPluginImagePreview,
        FilePondPluginFileValidateType
    );

    // Initialize FilePond
    const pond = FilePond.create(document.querySelector('.filepond'), {
        allowMultiple: true,
        maxFiles: 5,
        acceptedFileTypes: ['image/jpeg', 'image/png'],
        labelIdle: 'Drag & Drop images or <span class="filepond--label-action">Browse</span>',
        // For edit mode: load existing images
        <%--files: [--%>
        <%--    <c:forEach items="${car.images}" var="image">--%>
        <%--    {--%>
        <%--        source: '${image.url}',--%>
        <%--        options: {--%>
        <%--            type: 'local'--%>
        <%--        }--%>
        <%--    },--%>
        <%--    </c:forEach>--%>
        <%--]--%>
    });

    FilePond.setOptions({
        server: {
            process: '${pageContext.request.contextPath}/upload',
            revert: null, // Optional
            headers: {
                'X-CSRF-TOKEN': 'your_csrf_token_here' // If needed for security
            }
        },
        onprocessfile: (error, file) => {
            if (!error) {
                let input = document.createElement("input");
                input.type = "hidden";
                input.name = "imagePaths";  // Send file path with form data
                input.value = file.serverId;
                document.querySelector("form").appendChild(input);
            }
        }
    });

</script>
