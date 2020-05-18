package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.ProductDAO;
import Entities.CartBean;
import Entities.Product;

@WebServlet(urlPatterns = { "/CartBeanController" })
public class CartBeanController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	ProductDAO dao = new ProductDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		CartBean cartBean = (CartBean) session.getAttribute("CartBean");

		int idProduct = Integer.parseInt(req.getParameter("idProduct"));
		String command = req.getParameter("command");

		String url = "cart.jsp";

		try {
			Product product = dao.findByID(idProduct);
			switch (command) {
			case "insertItem":
				cartBean.insertToCart(product, 1);
				url = "cart.jsp";
				break;
			case "addItem":
				cartBean.insertToCart(product, 1);
				url = "cart.jsp";
				break;
			case "subItem":
				cartBean.removeToCart(product, 1);
				url = "cart.jsp";
				break;
			case "removeItem":
				cartBean.removeCart(product);
				url = "cart.jsp";
				break;
			case "removeCart":
				session.removeAttribute("CartBean");
				session.setAttribute("CartBean", new CartBean());
				url = "cart.jsp";
				break;
			default:
				url = "cart.jsp";
				break;
			}
			resp.sendRedirect(url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}
}
