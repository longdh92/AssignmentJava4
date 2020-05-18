package DAO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import Entities.Product;
import Utils.HibernateUtils;

public class ProductDAO {
	SessionFactory sessionFactory = HibernateUtils.getSessionFactory();

	public void insertProduct(Product product) {
		Session session = null;
		Transaction transaction = null;
		try {
			session = sessionFactory.openSession();
			transaction = session.beginTransaction();
			session.save(product);
			transaction.commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public List<Product> getAllProducts() {
		Session session = null;
		Transaction transaction = null;
		List<Product> list = null;
		try {
			session = sessionFactory.openSession();
			transaction = session.beginTransaction();
			list = session.createQuery("FROM Product").list();
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	public Product findByID(int id) {
		Session session = null;
		try {
			session = sessionFactory.openSession();
			return (Product) session.get(Product.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	public Product findByName(String productName) {
		Session session = null;
		Transaction transaction = null;
		List<Product> list = null;
		try {
			session = sessionFactory.openSession();
			transaction = session.beginTransaction();
			list = session.createQuery("FROM Product where productName like '%" + productName + "%'").list();
			if (list.size() > 0) {
				return list.get(0);
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	public void updateProduct(Product product) {
		Session session = null;
		Transaction transaction = null;
		try {
			session = sessionFactory.openSession();
			transaction = session.beginTransaction();
			session.update(product);
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			throw new RuntimeException(e);
		} finally {
			session.close();
		}
	}

	public void deleteProduct(Product product) {
		Session session = null;
		Transaction transaction = null;
		try {
			session = sessionFactory.openSession();
			transaction = session.beginTransaction();
			session.delete(product);
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			throw new RuntimeException(e);
		} finally {
			session.close();
		}
	}

	public List<Product> getListProductByPagination(List<Product> list, int start, int end) {
		List<Product> result = new ArrayList<Product>();
		for (int i = start; i < end; i++) {
			result.add(list.get(i));
		}
		return result;
	}
}
