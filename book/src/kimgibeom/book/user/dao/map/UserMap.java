package kimgibeom.book.user.dao.map;

import java.util.List;

import kimgibeom.book.user.domain.User;

public interface UserMap {
	User getUser(String userId);

	List<User> getUsers();

	int addUser(User user);

	List<User> getUserIds();

	int updateUserPw(User user);

	int updateUserName(User user);

	int updateUserPhoneNumber(User user);

	int updateUserGender(User user);

	int updateUserEmail(User user);

	int updateUserAddress(User user);

	int updateUserBirthDate(User user);

	int delUser(String userId);

	List<User> searchUser(String userId);
}