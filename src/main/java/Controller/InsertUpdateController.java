package Controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import DAO.UserDao;
import Entities.Category;
import Entities.Product;
import Entities.User;
import Utils.ShareHelper;

/**
 * Servlet implementation class InsertOrUpdateController
 */
@WebServlet(urlPatterns = { "/InsertUpdateController" })
@MultipartConfig
public class InsertUpdateController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	CategoryDAO categoryDAO = new CategoryDAO();
	ProductDAO productDAO = new ProductDAO();
	UserDao userDAO = new UserDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String command = req.getParameter("command");
		String productName = req.getParameter("productName");
		String category = req.getParameter("category");
		String image = req.getParameter("image");
		Part part = req.getPart("file");

		String message = "";
		session.setAttribute("message", message);
		String url = "edit.jsp";

		switch (command) {
		case "insertProduct":
			try {
				int price = Integer.parseInt(req.getParameter("price"));
				String message1 = message(productName, price, category, part);
				Category category2 = categoryDAO.findByName(category);
				if (message1.length() == 0) {
					Product product = new Product();
					product.setProductName(productName);
					product.setPrice(price);
					product.setImage(part.getSubmittedFileName());
					product.setIdCategory(category2);
					productDAO.insertProduct(product);
					message = "Insert Successful";
					session.setAttribute("alert", "success");
					url = "edit.jsp";
					this.saveImage(part, session, req, resp);
				} else if (message1.equals("Choose an image")) {
					if (image.length() == 0 || image == null) {
						message = message1;
						session.setAttribute("alert", "danger");
						url = "edit.jsp";
						break;
					}
					Product product = new Product();
					product.setProductName(productName);
					product.setPrice(price);
					product.setImage(image);
					product.setIdCategory(category2);
					productDAO.insertProduct(product);
					message = "Insert Successful";
					session.setAttribute("alert", "success");
					url = "edit.jsp";
				} else {
					message = message1;
					session.setAttribute("alert", "danger");
					url = "edit.jsp";
				}
			} catch (Exception e) {
				message = "Insert Failed";
				session.setAttribute("alert", "danger");
				url = "edit.jsp";
			}
			break;
		case "updateProduct":
			try {
				int idProduct = Integer.parseInt(req.getParameter("idProduct"));
				int price = Integer.parseInt(req.getParameter("price"));
				String message1 = message(productName, price, category, part);
				Category category2 = categoryDAO.findByName(category);
				if (message1.length() == 0) {
					Product product = new Product();
					product.setIdProduct(idProduct);
					product.setProductName(productName);
					product.setPrice(price);
					product.setImage(part.getSubmittedFileName());
					product.setIdCategory(category2);
					productDAO.updateProduct(product);
					session.setAttribute("product", product);
					message = "Update Successful";
					session.setAttribute("alert", "success");
					url = "edit.jsp";
					this.saveImage(part, session, req, resp);
				} else if (message1.equals("Choose an image")) {
					Product product = new Product();
					product.setIdProduct(idProduct);
					product.setProductName(productName);
					product.setPrice(price);
					product.setImage(image);
					product.setIdCategory(category2);
					productDAO.updateProduct(product);
					session.setAttribute("product", product);
					message = "Update Successful";
					session.setAttribute("alert", "success");
					url = "edit.jsp";
				} else {
					message = message1;
					session.setAttribute("alert", "danger");
					url = "edit.jsp";
				}
			} catch (Exception e) {
				message = "Update Failed";
				session.setAttribute("alert", "danger");
				url = "edit.jsp";
			}
			break;
		case "updateUser":
			try {
				int idUser = Integer.parseInt(req.getParameter("idUser"));
				String username = req.getParameter("username");
				if (!username.matches("[a-zA-Z0-9]+")) {
					session.setAttribute("message", "Only alphabet characters and numbers");
					session.setAttribute("alert", "danger");
					url = "editUser.jsp";
					resp.sendRedirect("admin/" + url);
					return;
				}
				String email = req.getParameter("email");
				if (!email.matches("\\w+@\\w+(\\.\\w+){1,2}")) {
					session.setAttribute("message", "Invalid email address!");
					session.setAttribute("alert", "danger");
					url = "editUser.jsp";
					resp.sendRedirect("admin/" + url);
					return;
				}
				String password = req.getParameter("password");
				String confirm = req.getParameter("confirm");
				if (password.length() < 3) {
					session.setAttribute("message", "Password at least 3 letters");
					session.setAttribute("alert", "danger");
					url = "editUser.jsp";
					resp.sendRedirect("admin/" + url);
					return;
				}
				if (!password.equals(confirm)) {
					session.setAttribute("message", "Password and confirm password not match");
					session.setAttribute("alert", "danger");
					url = "editUser.jsp";
					resp.sendRedirect("admin/" + url);
					return;
				}
				User user = userDAO.findByID(idUser);
				user.setUsername(username);
				user.setEmail(email);
				user.setPassword(password);
				userDAO.updateUser(user);

				if (ShareHelper.ADMIN.getIdUser() == idUser) {
					ShareHelper.ADMIN = user;
				}
				session.setAttribute("user", user);

				message = "Update Successful";
				session.setAttribute("alert", "success");
				url = "editUser.jsp";
			} catch (Exception e) {
				session.setAttribute("message", "Update Failed");
				session.setAttribute("alert", "danger");
				url = "editUser.jsp";
			}
			break;
		default:
			break;
		}
		session.setAttribute("message", message);
		resp.sendRedirect("admin/" + url);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}

	public String message(String productName, int price, String category, Part part) {
		if (productName.length() == 0) {
			return "Product Name Empty";
		}
		if (price <= 0) {
			return "Price must be higher than 0";
		}
		if (category.length() == 0) {
			return "Category Empty";
		}
		if (part.getSubmittedFileName().length() == 0) {
			return "Choose an image";
		}
		return "";
	}

	public void saveImage(Part part, HttpSession session, HttpServletRequest req, HttpServletResponse resp) {
		try {
			String fileName = part.getSubmittedFileName();
			if (fileName.length() > 0) {
				String path = "D:\\JavaEE\\AssignmentJava4\\src\\main\\webapp\\images\\home\\" + fileName;
				String path1 = "D:\\JavaEE\\AssignmentJava4\\src\\main\\webapp\\admin\\images\\home\\" + fileName;
				String path2 = getServletContext().getRealPath("/images/home" + File.separator + fileName);
				String path3 = getServletContext().getRealPath("/admin/images/home" + File.separator + fileName);

				InputStream is = part.getInputStream();
				byte[] bytes = IOUtils.toByteArray(is);
				FileUtils.writeByteArrayToFile(new File(path), bytes);
				FileUtils.writeByteArrayToFile(new File(path1), bytes);
				FileUtils.writeByteArrayToFile(new File(path2), bytes);
				FileUtils.writeByteArrayToFile(new File(path3), bytes);
				session.setAttribute("message", "");
			} else {
				session.setAttribute("message", "Choose an image");
				req.getRequestDispatcher("admin/edit.jsp").forward(req, resp);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
