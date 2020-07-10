package kimgibeom.book.delivery.service;

import java.util.List;

import kimgibeom.book.delivery.dao.DeliveryDao;
import kimgibeom.book.delivery.dao.DeliveryDaoImpl;
import kimgibeom.book.delivery.domain.Delivery;

public class DeliveryServiceImpl implements DeliveryService {
	private DeliveryDao deliveryDao;

	public DeliveryServiceImpl() {
		this.deliveryDao = new DeliveryDaoImpl();
	}

	@Override
	public Delivery findDelivery(int orderNum) {
		return deliveryDao.getDelivery(orderNum);
	}

	@Override
	public List<Delivery> readDeliveryCompleteList() {
		return deliveryDao.getDeliveryCompleteList();
	}

	@Override
	public boolean enrollDelivery(int orderNum, Delivery delivery) {
		return deliveryDao.addDelivery(orderNum, delivery) > 0;
	}
	
	@Override
	public List<Delivery> findUserDeliveryComplete(String userId){
		return deliveryDao.searchUserDeliveryComplete(userId);
	}
	
	@Override
	public List<Delivery> findUserPayComplete(String userId){
		return deliveryDao.searchUserPayComplete(userId);
	}
}