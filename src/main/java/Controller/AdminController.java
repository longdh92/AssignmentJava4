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

import DAO.UserDao;
import Entities.User;
import Utils.ShareHelper;

@WebServlet(urlPatterns = { "/AdminController" })
public class AdminController extends HttpServlet {

	UserDao dao = new UserDao();
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String command = req.getParameter("command");
		HttpSession session = req.getSession();
		session.setAttribute("message", "");
		switch (command) {
		case "login":
			String username = req.getParameter("username");
			String password = req.getParameter("password");
			String remember = req.getParameter("remember");
			session = req.getSession();
			User user = dao.findByUsername(username);
			if (user == null) {
				session.setAttribute("message", "User is not exists");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/login.jsp");
				return;
			}
			if (!user.isUserRole()) {
				session.setAttribute("message", "Login Failed");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/login.jsp");
				return;
			}

			if (user != null && password.equals(user.getPassword()) && user.isUserRole()) {

				session.setAttribute("username", username);
				resp.addCookie(new Cookie("cookieUsername", username));
				resp.addCookie(new Cookie("cookiePassword", password));
				resp.addCookie(new Cookie("cookieRemember", remember));

				ShareHelper.ADMIN = user;
				resp.sendRedirect("admin/admin.jsp");
			} else {
				ShareHelper.ADMIN = null;
				session.setAttribute("message", "Login failed");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/login.jsp");
			}
			break;
		case "create":
			String username1 = req.getParameter("username1");
			if (!username1.matches("[a-zA-Z0-9]+")) {
				session.setAttribute("message", "Only alphabet characters and numbers");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/register.jsp");
				return;
			}
			List<User> list = dao.getAllUser();
			for (User user2 : list) {
				if (username1.equalsIgnoreCase(user2.getUsername())) {
					session.setAttribute("message", "Can not use this username");
					session.setAttribute("alert", "danger");
					resp.sendRedirect("admin/register.jsp");
					return;
				}
			}
			String email1 = req.getParameter("email1");
			if (!email1.matches("\\w+@\\w+(\\.\\w+){1,2}")) {
				session.setAttribute("message", "Invalid email address!");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/register.jsp");
				return;
			}
			String password1 = req.getParameter("password1");
			if (password1.length() < 3) {
				session.setAttribute("message", "Password at least 3 letters");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/register.jsp");
				return;
			}
			String confirm1 = req.getParameter("confirm1");

			if (!password1.equals(confirm1)) {
				session.setAttribute("message", "Password and confirm password are not match");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/register.jsp");
				return;
			}

			User user1 = new User();
			user1.setUsername(username1);
			user1.setEmail(email1);
			user1.setPassword(password1);
			user1.setUserRole(true);
			dao.insertUser(user1);

			session.setAttribute("message", "Register Successfully");
			session.setAttribute("alert", "success");
			resp.sendRedirect("admin/register.jsp");
			break;
		case "update":
			String email2 = req.getParameter("email2");
			if (!email2.matches("\\w+@\\w+(\\.\\w+){1,2}")) {
				session.setAttribute("message", "Invalid email address!");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/user.jsp");
				return;
			}
			String password2 = req.getParameter("password2");
			if (password2.length() < 3) {
				session.setAttribute("message", "Password at least 3 letters");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/user.jsp");
				return;
			}
			String confirm2 = req.getParameter("confirm2");
			if (!password2.equals(confirm2)) {
				session.setAttribute("message", "Password and confirm password are not match");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/user.jsp");
				return;
			}
			ShareHelper.ADMIN.setEmail(email2);
			ShareHelper.ADMIN.setPassword(password2);
			dao.updateUser(ShareHelper.ADMIN);
			session.setAttribute("message", "Update Successfully");
			session.setAttribute("alert", "success");
			resp.sendRedirect("admin/user.jsp");
			break;
		case "editUser":
			int idUser1 = Integer.parseInt(req.getParameter("idUser"));
			User user3 = dao.findByID(idUser1);
			session.setAttribute("user", user3);
			resp.sendRedirect("admin/editUser.jsp");
			break;
		case "removeUser":
			int idUser = Integer.parseInt(req.getParameter("idUser"));
			if (ShareHelper.ADMIN.getIdUser() == idUser) {
				session.setAttribute("message", "Can not remove yourself");
				session.setAttribute("alert", "danger");
				resp.sendRedirect("admin/tableUser.jsp");
				return;
			}
			try {
				User user2 = dao.findByID(idUser);
				dao.deleteUser(user2);
				session.setAttribute("message", "Remove User Successfully");
				session.setAttribute("alert", "success");
				req.getRequestDispatcher("admin/tableUser.jsp").forward(req, resp);
			} catch (Exception e) {
				session.setAttribute("message", "Remove User Failed");
				session.setAttribute("alert", "danger");
				req.getRequestDispatcher("admin/tableUser.jsp").forward(req, resp);
			}
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
