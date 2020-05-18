package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ProductDAO;
import Entities.Product;

@WebServlet(urlPatterns = { "/SearchController" })
public class SearchController extends HttpServlet {

	ProductDAO productDAO = new ProductDAO();
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String command = req.getParameter("command");
		switch (command) {
		case "searchProduct":
			String productName = req.getParameter("search");
			Product product = productDAO.findByName(productName);
			req.setAttribute("ProductFound", product);
			req.getRequestDispatcher("detail.jsp").forward(req, resp);
			break;

		default:
			break;
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
