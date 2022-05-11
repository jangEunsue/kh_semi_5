package com.pet.model;

public class FreeBoardDTO {
	private int free_no;
	private String free_writer;
	private String free_id;
	private String free_title;
	private String free_cont;
	private String free_pwd;
	private int free_hit;
	private String free_date;
	private String free_update;
	private int free_group;		// -- 게시판 글 그룹
	private int free_step;
	private int free_indent;
	
	
	public int getFree_no() {
		return free_no;
	}
	public void setFree_no(int free_no) {
		this.free_no = free_no;
	}
	public String getFree_writer() {
		return free_writer;
	}
	public void setFree_writer(String free_writer) {
		this.free_writer = free_writer;
	}
	
	public String getFree_id() {
		return free_id;
	}
	public void setFree_id(String free_id) {
		this.free_id = free_id;
	}
	public String getFree_title() {
		return free_title;
	}
	public void setFree_title(String free_title) {
		this.free_title = free_title;
	}
	public String getFree_cont() {
		return free_cont;
	}
	public void setFree_cont(String free_cont) {
		this.free_cont = free_cont;
	}
	public String getFree_pwd() {
		return free_pwd;
	}
	public void setFree_pwd(String free_pwd) {
		this.free_pwd = free_pwd;
	}
	public int getFree_hit() {
		return free_hit;
	}
	public void setFree_hit(int free_hit) {
		this.free_hit = free_hit;
	}
	
	public String getFree_date() {
		return free_date;
	}
	public void setFree_date(String free_date) {
		this.free_date = free_date;
	}
	public String getFree_update() {
		return free_update;
	}
	public void setFree_update(String free_update) {
		this.free_update = free_update;
	}
	public int getFree_group() {
		return free_group;
	}
	public void setFree_group(int free_group) {
		this.free_group = free_group;
	}
	public int getFree_step() {
		return free_step;
	}
	public void setFree_step(int free_step) {
		this.free_step = free_step;
	}
	public int getFree_indent() {
		return free_indent;
	}
	public void setFree_indent(int free_indent) {
		this.free_indent = free_indent;
	}
	
	
}
