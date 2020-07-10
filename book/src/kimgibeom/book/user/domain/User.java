package kimgibeom.book.user.domain;

import java.sql.Date;

public class User {
	private String userId;
	private String userPw;
	private String userName;
	private String userGender;
	private Date userBirthDate;
	private String userEmail;
	private String userPhoneNumber;
	private String userAddress;
	private Date userRegDate;

	public String toString() {
		return String.format("%s %s %s %s", userId, userName,userPhoneNumber, userAddress);
	}

	public User() {
	}

	public User(String userId, String userPw, String userName, String userGender, Date userBirthDate, String userEmail,
			String userPhoneNumber, String userAddress) {
		this.userId = userId;
		this.userPw = userPw;
		this.userName = userName;
		this.userGender = userGender;
		this.userBirthDate = userBirthDate;
		this.userEmail = userEmail;
		this.userPhoneNumber = userPhoneNumber;
		this.userAddress = userAddress;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}

	public void setUserPhoneNumber(String userPhoneNumber) {
		this.userPhoneNumber = userPhoneNumber;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	public Date getUserBirthDate() {
		return userBirthDate;
	}

	public void setUserBirthDate(Date userBirthDate) {
		this.userBirthDate = userBirthDate;
	}

	public Date getUserRegDate() {
		return userRegDate;
	}

	public void setUserRegDate(Date userRegDate) {
		this.userRegDate = userRegDate;
	}
}