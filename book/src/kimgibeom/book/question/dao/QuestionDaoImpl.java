package kimgibeom.book.question.dao;

import java.util.List;

import kimgibeom.book.config.Configuration;
import kimgibeom.book.question.dao.map.QuestionMap;
import kimgibeom.book.question.domain.Question;

public class QuestionDaoImpl implements QuestionDao {
	QuestionMap questionMap;

	public QuestionDaoImpl() {
		this.questionMap = Configuration.getMapper(QuestionMap.class);
	}

	@Override
	public List<Question> getTotQuestions() {
		return questionMap.getTotQuestions();
	}

	@Override
	public Question getQuestion(int questionNum) {
		return questionMap.getQuestion(questionNum);
	}

	@Override
	public int addQuestion(Question question) {
		return questionMap.addQuestion(question);
	}

	@Override
	public int updateQuestion(Question question) {
		return questionMap.updateQuestion(question);
	}

	@Override
	public int delQuestion(int questionNum) {
		return questionMap.delQuestion(questionNum);
	}

	@Override
	public List<Question> searchUserId(String userId) {
		return questionMap.searchUserId(userId);
	}

	@Override
	public List<Question> searchTitle(String title) {
		return questionMap.searchTitle(title);
	}
}