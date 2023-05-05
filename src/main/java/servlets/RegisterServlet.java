package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;

import mycart.entities.User;
import mycart.helper.FactoryProvider;

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterServlet() {
		super();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String userName = request.getParameter("user_name");
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			String userPhone = request.getParameter("user_phone");
			String userAddress = request.getParameter("user_address");

			// Validation
			PrintWriter out = response.getWriter();
			if (userName.isEmpty()) {
				out.println("Name is blank");
				return;
			}

			// creating user object to store data

			User user = new User(userName, userEmail, userPassword, userPhone, "default.jpg", userAddress, "normal");

			Session hibernateSession = FactoryProvider.getFactory().openSession();
			Transaction tx = hibernateSession.beginTransaction();

			int userId= (Integer) hibernateSession.save(user);

			tx.commit();
		
			hibernateSession.close();
			response.setContentType("text/html");
			
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("message", "Registration successful !! Your user id is "+ userId);
			
			response.sendRedirect("register.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
