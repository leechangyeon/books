package kimgibeom.book.question.service;

import java.util.List;

import kimgibeom.book.question.dao.QuestionDao;
import kimgibeom.book.question.dao.QuestionDaoImpl;
import kimgibeom.book.question.domain.Question;

public class QuestionServiceImpl implements QuestionService {
	QuestionDao questionDao;

	public QuestionServiceImpl() {
		this.questionDao = new QuestionDaoImpl();
	}

	@Override
	public List<Question> listQuestions() {
		return this.questionDao.getTotQuestions();
	}

	@Override
	public Question findQuestion(int questionNum) {
		return this.questionDao.getQuestion(questionNum);
	}

	@Override
	public boolean enrollQuestion(Question question) {
		return this.questionDao.addQuestion(question) > 0;
	}

	@Override
	public boolean modifyQuestion(Question question) {
		return this.questionDao.updateQuestion(question) > 0;
	}

	@Override
	public boolean removeQuestion(int index) {
		return this.questionDao.delQuestion(index) > 0;
	}

	@Override
	public List<Question> lookupUserId(String userId) {
		return this.questionDao.searchUserId(userId);
	}

	@Override
	public List<Question> lookupTitle(String title) {
		return this.questionDao.searchTitle(title);
	}
}