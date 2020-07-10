package kimgibeom.book.question.service;

import java.util.List;

import kimgibeom.book.question.domain.Question;

public interface QuestionService {
	List<Question> listQuestions();

	Question findQuestion(int questionNum);

	boolean enrollQuestion(Question question);

	boolean modifyQuestion(Question question);

	boolean removeQuestion(int index);

	List<Question> lookupUserId(String userId);

	List<Question> lookupTitle(String title);
}