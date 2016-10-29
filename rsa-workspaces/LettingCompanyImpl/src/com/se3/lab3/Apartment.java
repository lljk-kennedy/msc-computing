package com.se3.lab3;

public class Apartment {
	
	String aptNumber;
	double monthlyRent;
	boolean occupied;
	
	public Apartment(String thisAptNumber)
	{
		aptNumber = thisAptNumber;
	}
	
	public boolean isOccupied()
	{
		return occupied;
	}
	
	public double getMonthlyRent()
	{
		return monthlyRent;
	}

	public void setMonthlyRent(double rentToSet) {
		// TODO Auto-generated method stub
		monthlyRent = rentToSet;
	}

}
