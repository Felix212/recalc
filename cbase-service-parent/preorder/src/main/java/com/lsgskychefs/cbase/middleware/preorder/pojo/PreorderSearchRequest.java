package com.lsgskychefs.cbase.middleware.preorder.pojo;

public class PreorderSearchRequest {
	//External Order Reference Number used during the order creation
	private String externalOrderReferenceNumber;
	
	//Booking Id used during the order creation
	private String bookingId;

	//Booking PNR of the Booking used during the order creation
	private String pnr;

	//FlightNumber of the Booking used during the order creation If the Booking contains multiple legs, during the order creation each item has to be assigned to a flight number
	private String flightNumber;

	//FlightDate of the Booking used during the order creation If the Booking contains multiple legs, during the order creation each item has to be assigned to a flight number and date
	private String flightDate;

	//Departure Airport of the Booking used during the order creation If the Booking contains multiple legs, during the order creation each item has to be assigned to a flight number and date Currently is not possible to assign a preorder item to a specific departure airport, means there is a limitation on having bookings with multiple flights with the same flight number
	private String fromAirportCode;

	//Arrival Airport of the Booking used during the order creation If the Booking contains multiple legs, during the order creation each item has to be assigned to a flight number and date Currently is not possible to assign a preorder item to a specific arrival airport, means there is a limitation on having bookings with multiple flights with the same flight number
	private String toAirportCode;

	//[ 1, 2, 3, 4, 5, 6 ]
	private Integer status;

	public String getExternalOrderReferenceNumber() {
		return externalOrderReferenceNumber;
	}

	public void setExternalOrderReferenceNumber(String externalOrderReferenceNumber) {
		this.externalOrderReferenceNumber = externalOrderReferenceNumber;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
