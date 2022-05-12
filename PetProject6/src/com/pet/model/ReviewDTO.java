package com.pet.model;

public class ReviewDTO {
    private int review_no;
    private int pnum;
    private String review_cont;
    private String userID;
    private String rimage;
    private String review_date;
    private int review_group;
    private int review_step;
    private int review_indent;
    private int sale_no;
    private String sale_date;
    
    
	public String getSale_date() {
		return sale_date;
	}
	public void setSale_date(String sale_date) {
		this.sale_date = sale_date;
	}
	public int getSale_no() {
		return sale_no;
	}
	public void setSale_no(int sale_no) {
		this.sale_no = sale_no;
	}
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getReview_cont() {
		return review_cont;
	}
	public void setReview_cont(String review_cont) {
		this.review_cont = review_cont;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getRimage() {
		return rimage;
	}
	public void setRimage(String rimage) {
		this.rimage = rimage;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	public int getReview_group() {
		return review_group;
	}
	public void setReview_group(int review_group) {
		this.review_group = review_group;
	}
	public int getReview_step() {
		return review_step;
	}
	public void setReview_step(int review_step) {
		this.review_step = review_step;
	}
	public int getReview_indent() {
		return review_indent;
	}
	public void setReview_indent(int review_indent) {
		this.review_indent = review_indent;
	}
    

}
