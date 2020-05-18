package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.SessionFactory;

import DAO.UserDao;
import Entities.User;
import Utils.HibernateUtils;
import Utils.ShareHelper;

@WebServlet(urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
	SessionFactory factory = HibernateUtils.getSessionFactory();
	UserDao dao = new UserDao();
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<User> list = dao.getAllUser();
		HttpSession session = req.getSession();
		String command = req.getParameter("command");
		switch (command) {
		case "login":
			String username = req.getParameter("username");
			String password = req.getParameter("password");
			String remember = req.getParameter("remember");
			User user = dao.findByUsername(username);
			if (user == null) {
				session.setAttribute("message2", "User is not exists");
				session.setAttribute("alert2", "danger");
				resp.sendRedirect("login.jsp");
				return;
			}
			if (user.isUserRole()) {
				session.setAttribute("message2", "Login failed");
				session.setAttribute("alert2", "danger");
				resp.sendRedirect("login.jsp");
				return;
			}
			if (user != null && password.equals(user.getPassword())) {

				session.setAttribute("username", username);
				session.setAttribute("message2", "");
				resp.addCookie(new Cookie("cookieUsername", username));
				resp.addCookie(new Cookie("cookiePassword", password));
				resp.addCookie(new Cookie("cookieRemember", remember));

				ShareHelper.USER = user;
				resp.sendRedirect("index.jsp");
			} else {
				session.setAttribute("message2", "Login failed");
				session.setAttribute("alert2", "danger");
				resp.sendRedirect("login.jsp");
				return;
			}
			break;
		case "register":
			String username1 = req.getParameter("username1");
			if (!username1.matches("[a-zA-Z0-9]+")) {
				session.setAttribute("message1", "Only alphabet characters and numbers");
				session.setAttribute("alert1", "danger");
				resp.sendRedirect("login.jsp");
				return;
			}
			for (User user1 : list) {
				if (username1.equalsIgnoreCase(user1.getUsername())) {
					session.setAttribute("message1", "Can not use this username");
					session.setAttribute("alert1", "danger");
					resp.sendRedirect("login.jsp");
					return;
				}
			}
			String email1 = req.getParameter("email1");
			if (!email1.matches("\\w+@\\w+(\\.\\w+){1,2}")) {
				session.setAttribute("message1", "Invalid email address!");
				session.setAttribute("alert1", "danger");
				resp.sendRedirect("login.jsp");
				return;
			}
			String password1 = req.getParameter("password1");
			if (password1.length() < 3) {
				session.setAttribute("message1", "Password at least 3 letters");
				session.setAttribute("alert1", "danger");
				resp.sendRedirect("login.jsp");
				return;
			}

			User user2 = new User();
			user2.setUsername(username1);
			user2.setEmail(email1);
			user2.setPassword(password1);
			user2.setUserRole(false);

			dao.insertUser(user2);
			session.setAttribute("message1", "Register Successfull");
			session.setAttribute("alert1", "success");
			req.getRequestDispatcher("login.jsp").forward(req, resp);
			break;
		case "update":
			String email2 = req.getParameter("email2");
			if (!email2.matches("\\w+@\\w+(\\.\\w+){1,2}")) {
				session.setAttribute("message3", "Invalid email address!");
				session.setAttribute("alert3", "danger");
				resp.sendRedirect("user.jsp");
				return;
			}
			String password2 = req.getParameter("password2");
			if (password2.length() < 3) {
				session.setAttribute("message3", "Password at least 3 letters");
				session.setAttribute("alert3", "danger");
				resp.sendRedirect("user.jsp");
				return;
			}
			ShareHelper.USER.setEmail(email2);
			ShareHelper.USER.setPassword(password2);
			dao.updateUser(ShareHelper.USER);
			session.setAttribute("message3", "Update Successfull");
			session.setAttribute("alert3", "success");
			resp.sendRedirect("user.jsp");
			break;
		default:
			break;
		}

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}
}
