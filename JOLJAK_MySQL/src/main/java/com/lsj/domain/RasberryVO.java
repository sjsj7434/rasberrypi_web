package com.lsj.domain;

import java.sql.Timestamp;

public class RasberryVO {

	private float temp;
	private float hud;
	private String id;
	private Timestamp time;
	private boolean isOn;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public boolean isOn() {
		return isOn;
	}
	public void setOn(boolean isOn) {
		this.isOn = isOn;
	}
	public float getTemp() {
		return temp;
	}
	public void setTemp(float temp) {
		this.temp = temp;
	}
	public float getHud() {
		return hud;
	}
	public void setHud(float hud) {
		this.hud = hud;
	}
	
}
