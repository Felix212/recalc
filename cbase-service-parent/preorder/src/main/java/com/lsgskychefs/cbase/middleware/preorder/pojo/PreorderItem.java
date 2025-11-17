package com.lsgskychefs.cbase.middleware.preorder.pojo;

public class PreorderItem {
	//Preorder ID
	private String id;
	
	//Preorder status
	private Integer status;
	
	//First Name of the passenger receiving the preorder (coming from the Booking)
	private String firstName;

	//Last Name of the passenger receiving the preorder (coming from the Booking)
	private String lastName;

	//Booking Id used during the creation of the preorder
	private String bookingId;

	//Booking PNR used during the creation of the preorder
	private String pnr;

	//Preorder external order reference set during preorder creation
	private String externalOrderReferenceNumber;

	//Preorder reference set during preorder creation
	private String orderReferenceNumber;

	//Departure Airport of the leg where the preorder is going to be delivered to
	private String fromAirportCode;

	//Departure Airport of the leg where the preorder is going to be delivered to
	private String toAirportCode;
	
	//Flight Number of the leg where the preorder is going to be delivered to
	private String flightNumber;

	//Flight Date of the leg where the preorder is going to be delivered to. Local Date time.
	private String flightDate;

	//	Seat Number of the passenger receiving the order if set originally
	private String seatNumber;

	//Passenger Class of the passenger receiving the order if set originally
	private String passengerClass;

	//Unique ID per item
	private String itemId;
	
	//Product ID
	private String productId;
	
	//Product code
	private String productCode;

	//External Product Code
	private String externalProductCode;
	
	//Product Name
	private String productName;

	//Quantity Ordered
	private Integer quantity;
	
	//Date of Creation of the record
	private String dateCreated;
	
	//Passenger ID receiving the order
	private String passengerId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getBookingId() {
		return bookingId;
	}

	public void setBookingId(String bookingId) {
		this.bookingId = bookingId;
	}

	public String getPnr() {
		return pnr;
	}

	public void setPnr(String pnr) {
		this.pnr = pnr;
	}

	public String getExternalOrderReferenceNumber() {
		return externalOrderReferenceNumber;
	}

	public void setExternalOrderReferenceNumber(String externalOrderReferenceNumber) {
		this.externalOrderReferenceNumber = externalOrderReferenceNumber;
	}

	public String getOrderReferenceNumber() {
		return orderReferenceNumber;
	}

	public void setOrderReferenceNumber(String orderReferenceNumber) {
		this.orderReferenceNumber = orderReferenceNumber;
	}

	public String getFromAirportCode() {
		return fromAirportCode;
	}

	public void setFromAirportCode(String fromAirportCode) {
		this.fromAirportCode = fromAirportCode;
	}

	public String getToAirportCode() {
		return toAirportCode;
	}

	public void setToAirportCode(String toAirportCode) {
		this.toAirportCode = toAirportCode;
	}

	public String getFlightNumber() {
		return flightNumber;
	}

	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}

	public String getFlightDate() {
		return flightDate;
	}

	public void setFlightDate(String flightDate) {
		this.flightDate = flightDate;
	}

	public String getSeatNumber() {
		return seatNumber;
	}

	public void setSeatNumber(String seatNumber) {
		this.seatNumber = seatNumber;
	}

	public String getPassengerClass() {
		return passengerClass;
	}

	public void setPassengerClass(String passengerClass) {
		this.passengerClass = passengerClass;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getExternalProductCode() {
		return externalProductCode;
	}

	public void setExternalProductCode(String externalProductCode) {
		this.externalProductCode = externalProductCode;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}

	public String getPassengerId() {
		return passengerId;
	}

	public void setPassengerId(String passengerId) {
		this.passengerId = passengerId;
	}
	
}
