package com.lsj.domain;

import java.sql.Timestamp;

public class RasberryVO {

	private float temp_in;
	private float hud_in;
	private float temp_out;
	private float hud_out;
	private String serialnumber;
	private Timestamp time;
	private int isOn;
	private String datePicker;
	private int autoOnoff;
	private int manualOnoff;

	public String getSerialnumber() {
		return serialnumber;
	}

	public void setSerialnumber(String serialnumber) {
		this.serialnumber = serialnumber;
	}

	public int getAutoOnoff() {
		return autoOnoff;
	}

	public void setAutoOnoff(int autoOnoff) {
		this.autoOnoff = autoOnoff;
	}

	public int getManualOnoff() {
		return manualOnoff;
	}

	public void setManualOnoff(int manualOnoff) {
		this.manualOnoff = manualOnoff;
	}

	public float getTemp_in() {
		return temp_in;
	}

	public void setTemp_in(float temp_in) {
		this.temp_in = temp_in;
	}

	public float getHud_in() {
		return hud_in;
	}

	public void setHud_in(float hud_in) {
		this.hud_in = hud_in;
	}

	public float getTemp_out() {
		return temp_out;
	}

	public void setTemp_out(float temp_out) {
		this.temp_out = temp_out;
	}

	public float getHud_out() {
		return hud_out;
	}

	public void setHud_out(float hud_out) {
		this.hud_out = hud_out;
	}

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public int getIsOn() {
		return isOn;
	}

	public void setIsOn(int isOn) {
		this.isOn = isOn;
	}

	public String getDatePicker() {
		return datePicker;
	}

	public void setDatePicker(String datePicker) {
		this.datePicker = datePicker;
	}

}
