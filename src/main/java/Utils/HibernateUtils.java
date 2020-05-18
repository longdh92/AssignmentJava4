package Utils;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtils {
	public static SessionFactory getSessionFactory() {
		try {
			Configuration configuration = new Configuration();
			configuration.configure("hibernate.cfg.xml").configure();
			System.out.println("Hibernate Configuration loaded");

			SessionFactory sessionFactory = configuration.buildSessionFactory();
			return sessionFactory;
		} catch (Exception e) {
			System.err.println("Initial SessionFactory creation failed." + e);
			e.printStackTrace();
		}
		return null;
	}
}
