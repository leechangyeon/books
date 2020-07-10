package kimgibeom.book.delivery.service;

import java.util.List;

import kimgibeom.book.delivery.domain.Delivery;
import kimgibeom.book.order.domain.Order;

public interface DeliveryService {
	List<Delivery> readDeliveryCompleteList();

	Delivery findDelivery(int orderNum);

	boolean enrollDelivery(int orderNum, Delivery delivery);
	
	List<Delivery> findUserDeliveryComplete(String userId);
	
	List<Delivery> findUserPayComplete(String userId);
}