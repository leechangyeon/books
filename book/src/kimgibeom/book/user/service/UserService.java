package kimgibeom.book.user.service;

import java.util.List;

import kimgibeom.book.user.domain.User;

public interface UserService {
	User findUser(String userId);

	List<User> readUsers();

	boolean writeUser(User user);

	List<User> readUserIds();

	boolean modifyUserPw(User user);

	boolean modifyUserName(User user);

	boolean modifyUserPhoneNumber(User user);

	boolean modifyUserEmail(User user);

	boolean modifyUserAddress(User user);

	boolean modifyUserGender(User user);

	boolean modifyUserBirthDate(User user);

	boolean withdrawUser(String userId);

	List<User> lookupUser(String userId);
}