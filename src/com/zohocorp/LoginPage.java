package com.zohocorp;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.ArrayList;

@WebServlet("/LoginPage")
public class LoginPage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userName = request.getParameter("txtUserName");
		String password = request.getParameter("txtPassword");
		PrintWriter out = response.getWriter();
		String dbName = "jdbc:postgresql://localhost/sampleDB";
		String dbDriver = "org.postgresql.Driver";
		String dbuserName = "postgres";
		String dbpassword = "postgres";
		try {
			Class.forName(dbDriver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			Connection con = DriverManager.getConnection(dbName, dbuserName, dbpassword);
			Statement statement = con.createStatement();
			String sql = "SELECT * FROM logininfo";
			ResultSet rs = statement.executeQuery(sql);
			boolean flag = false;boolean userfound = false;
			ArrayList<LoginInfo> loginInfo = new ArrayList<LoginInfo>();
			while (rs.next()) {
				loginInfo.add(new LoginInfo(rs.getString(1), rs.getString(2)));
			}
			for (LoginInfo li : loginInfo) {
				if (userName.equals(li.userName) && password.equals(li.password)) {
					session.setAttribute("UserName", userName);	con.close();
						response.sendRedirect("home.jsp");
					flag = true;
					break;
				}
				if(userName.equals(li.userName)) {
					userfound = true;
				}
			}
			if (flag==false && userfound) {
				request.setAttribute("username", userName);con.close();
		        RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
		        rd.forward(request, response);
			}
			if(flag == false) {
				con.close();
				response.sendRedirect("index.jsp");
			}con.close();
		} catch (Exception e) {
			out.println(e.getMessage());
		}
	}
}