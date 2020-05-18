package Utils;

import Entities.User;

public class ShareHelper {

	public static User USER = null;
	public static User ADMIN = null;

	public static void logoff() {
		ShareHelper.USER = null;
	}

	public static boolean authenticated() {
		return ShareHelper.USER != null;
	}
}
