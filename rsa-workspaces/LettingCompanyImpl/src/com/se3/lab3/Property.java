package com.se3.lab3;

import java.util.ArrayList;
import java.util.List;

public class Property {
	
	String name;
	List<Apartment> apartments = new ArrayList<Apartment>();
	
	
	public Property(String thisName)
	{
		name = thisName;
	}
	
	public double computeMonthlyRent()
	{
		double monthlyRent = 0.0;
		
		for (int i = 0; i < apartments.size(); i++)
		{
			monthlyRent += apartments.get(i).monthlyRent;
		}
		
		return monthlyRent;
	}
	
	public void addApartment(Apartment thisApartment)
	{
		apartments.add(thisApartment);
	}

}
