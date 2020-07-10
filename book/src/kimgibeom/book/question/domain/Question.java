package kimgibeom.book.question.domain;

import java.sql.Date;

public class Question {
	private int questionNum;
	private String userId;
	private String title;
	private String content;
	private Date regDate;
	private String status;
	private String attachName;

	public Question() {
	}

	public Question(String userId, String title, String content, Date regDate, String status, String attachName) {
		this.userId = userId;
		this.title = title;
		this.content = content;
		this.regDate = regDate;
		this.status = status;
		this.attachName = attachName;
	}

	public int getQuestionNum() {
		return questionNum;
	}

	public void setQuestionNum(int questionNum) {
		this.questionNum = questionNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAttachName() {
		return attachName;
	}

	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}
}