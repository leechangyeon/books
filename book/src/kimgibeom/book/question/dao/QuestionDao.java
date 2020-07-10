package kimgibeom.book.question.dao;

import java.util.List;

import kimgibeom.book.question.domain.Question;

public interface QuestionDao {
	List<Question> getTotQuestions();

	Question getQuestion(int questionNum);

	int addQuestion(Question question);

	int updateQuestion(Question question);

	int delQuestion(int questionNum);

	List<Question> searchUserId(String userId);

	List<Question> searchTitle(String title);
}