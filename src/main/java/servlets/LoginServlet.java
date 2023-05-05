package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mycart.dao.UserDao;
import mycart.entities.User;
import mycart.helper.FactoryProvider;


public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			// Authenticating user
			UserDao userDao = new UserDao(FactoryProvider.getFactory());
			User user = userDao.getUserByEmailAndPassword(email, password);
			// System.out.println(user);
			
			HttpSession httpSession = request.getSession();
			
			
			
			
			PrintWriter out = response.getWriter();
			if(user==null)
			{
				httpSession.setAttribute("message", "Invalid details !! Please Sign up");
				response.sendRedirect("login.jsp");
				return;
			}
			else
			{
				// out.println("<h1>Welcome "+ user.getUserName() +"</h1>");
				
				// login
				httpSession.setAttribute("current-user", user);
				
				if(user.getUserType().equals("admin"))
				{
					response.sendRedirect("admin.jsp");
				}
				else if(user.getUserType().equals("normal"))
				{
					response.sendRedirect("normal.jsp");
				}
				else
				{
					out.println("We have not identified user type");
				}
				
			}
			
		
	}

}
