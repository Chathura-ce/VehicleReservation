package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/upload")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB per file
        maxRequestSize = 1024 * 1024 * 50    // 50MB total
)
public class UploadServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Define where the files should be uploaded
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        for (Part part : request.getParts()) {
            System.out.println("Part Name: " + part.getName()); // Debugging
            System.out.println("Part Size: " + part.getSize()); // Debugging

            // Check if this is a file (not a form field)
            if (part.getName().equals("carImages") && part.getSize() > 0) {
                String submittedFileName = part.getSubmittedFileName();

                if (submittedFileName == null || submittedFileName.isEmpty()) {
                    System.out.println("Error: Submitted file name is null or empty.");
                    continue; // Skip this iteration if the file name is invalid
                }

                String fileName = Paths.get(submittedFileName).getFileName().toString();
                String filePath = uploadPath + File.separator + fileName;
                part.write(filePath);

                System.out.println("File Uploaded: " + filePath);
                response.getWriter().write(fileName);
            }
        }

    }
}
