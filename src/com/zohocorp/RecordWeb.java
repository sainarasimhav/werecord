package com.zohocorp;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig(maxFileSize = 169999999)
@WebServlet("/RecordWeb")
public class RecordWeb extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	byte[] buffer = new byte[16 * 1024];

    	InputStream input = request.getInputStream();       
    	OutputStream output = new FileOutputStream("costam0.mp4");
    	int bytesRead;
    	while ((bytesRead = input.read(buffer)) != -1){
    	    output.write(buffer, 0, bytesRead);
    	}
    	output.close();
    	input.close();
	}
}
