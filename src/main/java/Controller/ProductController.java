package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import Entities.Product;

@WebServlet(urlPatterns = { "/ProductController" })
public class ProductController extends HttpServlet {

	ProductDAO productDAO = new ProductDAO();
	CategoryDAO categoryDAO = new CategoryDAO();

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int idProduct = Integer.parseInt(req.getParameter("idProduct"));
		String command = req.getParameter("command");
		HttpSession session = req.getSession();
		
		String url = "table.jsp";
		
		Product product = productDAO.findByID(idProduct);
		
		switch (command) {
		case "removeProduct":
			try {
				productDAO.deleteProduct(product);
			} catch (Exception e) {
				session.setAttribute("message", "Cannot remove this product");
				session.setAttribute("alert", "danger");
				url = "table.jsp";
				break;
			}
			session.setAttribute("message", "Remove Product Successfully");
			session.setAttribute("alert", "success");
			url = "table.jsp";
			break;
		case "editProduct":
			session.setAttribute("product", product);
			url = "edit.jsp";
			break;
		default:
			break;
		}
		resp.sendRedirect("admin/" + url);
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}
}
