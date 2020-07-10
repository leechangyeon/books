package kimgibeom.book.user.service;

import java.util.List;

import kimgibeom.book.user.dao.UserDao;
import kimgibeom.book.user.dao.UserDaoImpl;
import kimgibeom.book.user.domain.User;

public class UserServiceImpl implements UserService {
	private UserDao userDao;

	public UserServiceImpl() {
		this.userDao = new UserDaoImpl();
	}

	@Override
	public User findUser(String userId) {
		return userDao.getUser(userId);
	}

	@Override
	public boolean writeUser(User user) {
		return userDao.addUser(user) > 0;
	}

	@Override
	public List<User> readUserIds() {
		return userDao.getUserIds();
	}

	@Override
	public boolean modifyUserPw(User user) {
		return userDao.updateUserPw(user) > 0;
	}

	@Override
	public boolean modifyUserName(User user) {
		return userDao.updateUserName(user) > 0;
	}

	@Override
	public boolean modifyUserPhoneNumber(User user) {
		return userDao.updateUserPhoneNumber(user) > 0;
	}

	@Override
	public boolean modifyUserEmail(User user) {
		return userDao.updateUserEmail(user) > 0;
	}

	@Override
	public boolean modifyUserAddress(User user) {
		return userDao.updateUserAddress(user) > 0;
	}

	@Override
	public boolean modifyUserGender(User user) {
		return userDao.updateUserGender(user) > 0;
	}

	@Override
	public boolean withdrawUser(String userId) {
		return userDao.delUser(userId) > 0;
	}

	@Override
	public List<User> readUsers() {
		return userDao.getUsers();
	}

	@Override
	public List<User> lookupUser(String userId) {
		return userDao.searchUser(userId);
	}

	@Override
	public boolean modifyUserBirthDate(User user) {
		return userDao.updateUserBirthDate(user) > 0;
	}
}