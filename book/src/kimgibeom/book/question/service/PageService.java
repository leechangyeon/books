package kimgibeom.book.question.service;

import kimgibeom.book.question.domain.Page;

public interface PageService {
	Page getPage();
	
	boolean isPrev();
	
	boolean isNext();
	
	int getStartPage();
	
	int getEndPage();
}
