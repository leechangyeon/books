package kimgibeom.book.delivery.dao;

import java.util.List;

import kimgibeom.book.config.Configuration;
import kimgibeom.book.delivery.dao.map.DeliveryMap;
import kimgibeom.book.delivery.domain.Delivery;

public class DeliveryDaoImpl implements DeliveryDao {
	private DeliveryMap deliveryMap;

	public DeliveryDaoImpl() {
		this.deliveryMap = Configuration.getMapper(DeliveryMap.class);
	}

	@Override
	public Delivery getDelivery(int orderNum) {
		return deliveryMap.getDelivery(orderNum);
	}

	@Override
	public List<Delivery> getDeliveryCompleteList() {
		return deliveryMap.getDeliveryCompleteList();
	}

	@Override
	public int addDelivery(int orderNum, Delivery delivery) {
		return deliveryMap.addDelivery(orderNum, delivery);
	}
	
	@Override
	public List<Delivery> searchUserDeliveryComplete(String userId){
		return deliveryMap.searchUserDeliveryComplete(userId);
	}
	
	@Override
	public List<Delivery> searchUserPayComplete(String userId){
		return deliveryMap.searchUserPayComplete(userId);
	}
}
