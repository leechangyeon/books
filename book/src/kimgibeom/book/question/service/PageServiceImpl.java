package kimgibeom.book.question.service;

import kimgibeom.book.question.dao.PageDao;
import kimgibeom.book.question.dao.PageDaoImpl;
import kimgibeom.book.question.domain.Page;

public class PageServiceImpl implements PageService{
	private PageDao pageDao;
	
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int totRowCnt;
	private int pageNumCnt;
	private Page page;
	
	public PageServiceImpl(int pageNumCnt, Page page) {
		this.pageDao = new PageDaoImpl();
		this.totRowCnt = getTotRowCnt();
		this.pageNumCnt = pageNumCnt;
		this.page = page;
		init();
	}
	
	private int getTotRowCnt() {
		return pageDao.getTotRowCnt();
	}
	
	private void init() {
		endPage = (int)(Math.ceil(page.getCurrentPage()/(double)pageNumCnt)*pageNumCnt);
		startPage = (endPage-pageNumCnt)+1;
		int lastEndPage = (int)(Math.ceil(totRowCnt/(double)page.getRowCnt()));
		
		if(endPage > lastEndPage) endPage = lastEndPage;
		
		prev = startPage == 1 ? false:true;
		next = endPage * page.getRowCnt() >= totRowCnt ? false:true;
	}
	
	@Override
	public Page getPage() {
		return page;
	}
	
	@Override
	public boolean isPrev() {
		return prev;
	}
	
	@Override
	public boolean isNext() {
		return next;
	}
	
	@Override
	public int getStartPage() {
		return startPage;
	}
	
	@Override
	public int getEndPage() {
		return endPage;
	}
}
