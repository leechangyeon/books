package kimgibeom.book.order.domain;

import java.sql.Date;
import java.util.List;

import kimgibeom.book.book.domain.Book;
import kimgibeom.book.user.domain.User;

public class Order {
	private int orderNum;
	private Date orderDate;
	private String status;
	private int totalPrice;
	private User user;
	private List<OrderBook> order_books;
	private List<Book> books;
	
	public String toString() {
		return String.format("%d %d %s %s %s", this.orderNum,this.totalPrice,this.user,this.order_books,this.books);
	}

	public Order() {
	}

	public Order(int orderNum, Date orderDate, String status, int totalPrice) {
		this.orderNum = orderNum;
		this.orderDate = orderDate;
		this.status = status;
		this.totalPrice = totalPrice; 
	}

	public int getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<OrderBook> getOrder_books() {
		return order_books;
	}

	public void setOrder_books(List<OrderBook> order_books) {
		this.order_books = order_books;
	}

	public List<Book> getBooks() {
		return books;
	}

	public void setBooks(List<Book> books) {
		this.books = books;
	}
}