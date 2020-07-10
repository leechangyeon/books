package kimgibeom.book.user.dao;

import java.util.List;

import kimgibeom.book.config.Configuration;
import kimgibeom.book.user.dao.map.UserMap;
import kimgibeom.book.user.domain.User;

public class UserDaoImpl implements UserDao {
	private UserMap userMapper;

	public UserDaoImpl() {
		this.userMapper = Configuration.getMapper(UserMap.class);
	}

	@Override
	public User getUser(String userId) {
		return userMapper.getUser(userId);
	}

	@Override
	public int addUser(User user) {
		return userMapper.addUser(user);
	}

	@Override
	public List<User> getUserIds() {
		return userMapper.getUserIds();
	}

	@Override
	public int updateUserPw(User user) {
		return userMapper.updateUserPw(user);
	}

	@Override
	public int updateUserName(User user) {
		return userMapper.updateUserName(user);
	}

	@Override
	public int updateUserPhoneNumber(User user) {
		return userMapper.updateUserPhoneNumber(user);
	}

	@Override
	public int updateUserEmail(User user) {
		return userMapper.updateUserEmail(user);
	}

	@Override
	public int updateUserAddress(User user) {
		return userMapper.updateUserAddress(user);
	}

	@Override
	public int updateUserGender(User user) {
		return userMapper.updateUserGender(user);
	}

	@Override
	public int delUser(String userId) {
		return userMapper.delUser(userId);
	}

	@Override
	public List<User> getUsers() {
		return userMapper.getUsers();
	}

	@Override
	public List<User> searchUser(String userId) {
		return userMapper.searchUser(userId);
	}

	@Override
	public int updateUserBirthDate(User user) {
		return userMapper.updateUserBirthDate(user);
	}

}