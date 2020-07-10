package kimgibeom.book.question.domain;

public class Page {
	private int currentPage;
	private int rowCnt;
	
	public Page() {
		this(1, 10);
	}
	
	public Page(int currentPage) {
		this(currentPage, 10);
	}
	
	public Page(int currentPage, int rowCnt) {
		this.currentPage = currentPage;
		this.rowCnt = rowCnt;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getRowCnt() {
		return rowCnt;
	}

	public void setRowCnt(int rowCnt) {
		this.rowCnt = rowCnt;
	}
	
}
