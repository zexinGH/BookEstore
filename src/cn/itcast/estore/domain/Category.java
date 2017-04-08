package cn.itcast.estore.domain;

import java.io.Serializable;

public class Category implements Serializable{
	String name;
	
	public void setName(String name){
		this.name=name;
	}
	
	public String getName(){
		return this.name;
	}
}
