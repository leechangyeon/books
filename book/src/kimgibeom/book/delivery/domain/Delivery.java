package kimgibeom.book.delivery.domain;

import java.util.List;

import kimgibeom.book.book.domain.Book;
import kimgibeom.book.order.domain.Order;
import kimgibeom.book.order.domain.OrderBook;
import kimgibeom.book.user.domain.User;

public class Delivery {
	private String deliveryNum;
	private String company;
	private int price;
	private Order order;
	private List<OrderBook> orderBooks;
	private User user;
	private List<User> users;
	private List<Order> orders;
	private List<Book> books;

	public Delivery() {
	}

	public Delivery(String deliveryNum, String company, int price) {
		this.deliveryNum = deliveryNum;
		this.company = company;
		this.price = price;
	}

	public Delivery(String deliveryNum, String company, int price, Order order, List<OrderBook> orderBooks, User user,
			List<User> users, List<Order> orders, List<Book> books) {
		super();
		this.deliveryNum = deliveryNum;
		this.company = company;
		this.price = price;
		this.order = order;
		this.orderBooks = orderBooks;
		this.user = user;
		this.users = users;
		this.orders = orders;
		this.books = books;
	}

	public String getDeliveryNum() {
		return deliveryNum;
	}

	public void setDeliveryNum(String deliveryNum) {
		this.deliveryNum = deliveryNum;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public List<OrderBook> getOrderBooks() {
		return orderBooks;
	}

	public void setOrderBooks(List<OrderBook> orderBooks) {
		this.orderBooks = orderBooks;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}

	public List<Book> getBooks() {
		return books;
	}

	public void setBooks(List<Book> books) {
		this.books = books;
	}
}
