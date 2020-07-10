package kimgibeom.book.question.dao;

import kimgibeom.book.config.Configuration;
import kimgibeom.book.question.dao.map.PageMap;

public class PageDaoImpl implements PageDao{
	private PageMap pageMap;
	
	public PageDaoImpl() {
		this.pageMap = Configuration.getMapper(PageMap.class);
	}
	
	@Override
	public int getTotRowCnt() {
		return pageMap.getTotRowCnt();
	}
}
