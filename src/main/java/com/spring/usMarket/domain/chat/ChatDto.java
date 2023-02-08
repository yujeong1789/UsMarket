package com.spring.usMarket.domain.chat;

import java.util.Date;

public class ChatDto {
	private String room_no;			// 채팅방 번호
	private Integer chat_from;		// 보낸 회원 
	private Integer chat_to;		// 받는 회원	
	private String chat_content;	// 내용
	private Date chat_time;			// 보낸 시간
	private String chat_read;		// 읽음 여부, Y/N
	
	public ChatDto() {}

	public ChatDto(String room_no, Integer chat_from, Integer chat_to, String chat_content, Date chat_time,
			String chat_read) {
		this.room_no = room_no;
		this.chat_from = chat_from;
		this.chat_to = chat_to;
		this.chat_content = chat_content;
		this.chat_time = chat_time;
		this.chat_read = chat_read;
	}

	public String getRoom_no() {
		return room_no;
	}

	public void setRoom_no(String room_no) {
		this.room_no = room_no;
	}

	public Integer getChat_from() {
		return chat_from;
	}

	public void setChat_from(Integer chat_from) {
		this.chat_from = chat_from;
	}

	public Integer getChat_to() {
		return chat_to;
	}

	public void setChat_to(Integer chat_to) {
		this.chat_to = chat_to;
	}

	public String getChat_content() {
		return chat_content;
	}

	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}

	public Date getChat_time() {
		return chat_time;
	}

	public void setChat_time(Date chat_time) {
		this.chat_time = chat_time;
	}

	public String getChat_read() {
		return chat_read;
	}

	public void setChat_read(String chat_read) {
		this.chat_read = chat_read;
	}

	@Override
	public String toString() {
		return "ChatDto [room_no=" + room_no + ", chat_from=" + chat_from + ", chat_to=" + chat_to + ", chat_content="
				+ chat_content + ", chat_time=" + chat_time + ", chat_read=" + chat_read + "]";
	}
}
