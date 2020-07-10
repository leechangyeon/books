package kimgibeom.book.order.service;

import java.util.List;

import kimgibeom.book.order.dao.OrderDao;
import kimgibeom.book.order.dao.OrderDaoImpl;
import kimgibeom.book.order.domain.Order;
import kimgibeom.book.order.domain.OrderBook;

public class OrderServiceImpl implements OrderService {
	private OrderDao orderDao;

	public OrderServiceImpl() {
		this.orderDao = new OrderDaoImpl();
	}

	@Override
	public boolean putOrder(String userId, Order order) {
		return orderDao.addOrder(userId, order) > 0;
	}

	@Override
	public List<Order> readOrder(String userId) {
		return orderDao.getOrder(userId);
	}

	@Override
	public int putOrderBook(int orderNum, String bookIsbn, OrderBook orderBook) {
		return orderDao.addOrderBook(orderNum, bookIsbn, orderBook);
	}

	@Override
	public List<Order> readOrderInfos() {
		return orderDao.getOrderInfos();
	}

	@Override
	public boolean removeOrder(int orderNum) {
		return orderDao.delOrder(orderNum) > 0;
	}

	@Override
	public List<Order> readUserOrderInfos(String userId) {
		return orderDao.getUserOrderInfos(userId);
	}

	@Override
	public List<Order> findUserOrderInfos(String userId) {
		return orderDao.searchUserOrderInfos(userId);
	}

	@Override
	public int modifyOrderStatus(int orderNum) {
		return orderDao.updateOrderStatus(orderNum);
	}

	@Override
	public List<Order> readPayCompleteOrders() {
		return orderDao.getPayCompleteOrders();
	}

	@Override
	public List<Order> readPayCompleteOrder(int orderNum) {
		return orderDao.getPayCompleteOrder(orderNum);
	}
}