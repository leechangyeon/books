package kimgibeom.book.order.dao;

import java.util.List;

import kimgibeom.book.config.Configuration;
import kimgibeom.book.order.dao.map.OrderMap;
import kimgibeom.book.order.domain.Order;
import kimgibeom.book.order.domain.OrderBook;

public class OrderDaoImpl implements OrderDao {
	private OrderMap orderMap;

	public OrderDaoImpl() {
		orderMap = Configuration.getMapper(OrderMap.class);
	}

	@Override
	public int addOrder(String userId, Order order) {
		return orderMap.addOrder(userId, order);
	}

	@Override
	public List<Order> getOrder(String userId) {
		return orderMap.getOrder(userId);
	}

	@Override
	public int addOrderBook(int orderNum, String bookIsbn, OrderBook orderBook) {
		return orderMap.addOrderBook(orderNum, bookIsbn, orderBook);
	}

	@Override
	public List<Order> getOrderInfos() {
		return orderMap.getOrderInfos();
	}

	@Override
	public int delOrder(int orderNum) {
		return orderMap.delOrder(orderNum);
	}

	@Override
	public List<Order> getUserOrderInfos(String userId) {
		return orderMap.getUserOrderInfos(userId);
	}

	@Override
	public List<Order> searchUserOrderInfos(String userId) {
		return orderMap.searchUserOrderInfos(userId);
	}

	@Override
	public int updateOrderStatus(int orderNum) {
		return orderMap.updateOrderStatus(orderNum);
	}

	@Override
	public List<Order> getPayCompleteOrders() {
		return orderMap.getPayCompleteOrders();
	}

	@Override
	public List<Order> getPayCompleteOrder(int orderNum) {
		return orderMap.getPayCompleteOrder(orderNum);
	}
}