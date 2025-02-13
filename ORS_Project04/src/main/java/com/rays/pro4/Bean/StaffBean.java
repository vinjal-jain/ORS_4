package com.rays.pro4.Bean;

import java.util.Date;

public class StaffBean extends BaseBean {
	
	
	private String fullName;
	private Date joiningDate;
	private int division;
	private String previousEmployer;

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public Date getJoiningDate() {
		return joiningDate;
	}

	public void setJoiningDate(Date joiningDate) {
		this.joiningDate = joiningDate;
	}

	public int getDivision() {
		return division;
	}

	public void setDivision(int division) {
		this.division = division;
	}

	public String getPreviousEmployer() {
		return previousEmployer;
	}

	public void setPreviousEmployer(String previousEmployer) {
		this.previousEmployer = previousEmployer;
	}

	@Override
	public String getkey() {
		// TODO Auto-generated method stub
		return id+" ";
	}

	@Override
	public String getValue() {
		// TODO Auto-generated method stub
		return fullName;
	}

}