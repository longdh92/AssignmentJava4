package Controller;

import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.CartDao;
import DAO.CartDetailDAO;
import DAO.InvoiceDAO;
import DAO.UserDao;
import Entities.Cart;
import Entities.CartBean;
import Entities.CartDetail;
import Entities.Invoice;
import Entities.Product;
import Utils.ShareHelper;

@WebServlet(urlPatterns = { "/CheckOutController" })
public class CheckOutController extends HttpServlet {
	CartDao cartDao = new CartDao();
	CartDetailDAO cartDetailDAO = new CartDetailDAO();
	UserDao userDao = new UserDao();
	InvoiceDAO invoiceDAO = new InvoiceDAO();
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		HttpSession session = req.getSession();
		CartBean cartBean = (CartBean) session.getAttribute("CartBean");
		String command = req.getParameter("command");
		int total = Integer.parseInt(req.getParameter("total"));
		String yourname = req.getParameter("yourname");
		String phone = req.getParameter("phone");
		String email = req.getParameter("email");
		String address = req.getParameter("address");
		if (total == 0) {
			session.setAttribute("message", "0 item in Cart");
			session.setAttribute("alert", "danger");
			resp.sendRedirect("checkout.jsp");
			return;
		}
		if (!yourname.matches("^[a-zA-Z\\s\\p{L}]+")) {
			session.setAttribute("message", "Only alphabet and white space characters");
			session.setAttribute("alert", "danger");
			resp.sendRedirect("checkout.jsp");
			return;
		}
		if (!phone.matches("0\\d{9}")) {
			session.setAttribute("message", "Invalid phone number!");
			session.setAttribute("alert", "danger");
			resp.sendRedirect("checkout.jsp");
			return;
		}
		if (!email.matches("\\w+@\\w+(\\.\\w+){1,2}")) {
			session.setAttribute("message", "Invalid email address!");
			session.setAttribute("alert", "danger");
			resp.sendRedirect("checkout.jsp");
			return;
		}
		switch (command) {
		case "checkOut":
			Cart cart = new Cart();
			cartDao.insertCart(cart);
			TreeMap<Product, Integer> list = cartBean.getListProduct();
			for (Map.Entry<Product, Integer> entry : list.entrySet()) {
				CartDetail cartDetail = new CartDetail();
				cartDetail.setIdCart(cart);
				cartDetail.setIdProduct(entry.getKey());
				cartDetail.setQuantity(entry.getValue());
				cartDetailDAO.insertCartDetail(cartDetail);
			}
			Invoice invoice = new Invoice();
			if (ShareHelper.USER != null) {
				invoice.setIdUser(ShareHelper.USER);
			}
			invoice.setIdCart(cart);
			invoice.setPhone(phone);
			invoice.setAddress(address);
			invoice.setDate(new Date());
			invoice.setEmail(email);
			invoice.setTotal(total);
			invoice.setUsername(yourname);
			invoiceDAO.insertInvoice(invoice);
			session.setAttribute("message", "Successfull");
			session.setAttribute("alert", "success");
			session.removeAttribute("CartBean");
			session.setAttribute("CartBean", new CartBean());
			resp.sendRedirect("checkout.jsp");
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
