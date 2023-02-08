package com.spring.usMarket.domain.chat;

public class ChatRoomDto {
	private String room_no;
	private Integer chat_member_1;
	private Integer chat_member_2;
	
	public ChatRoomDto() {}
	
	public ChatRoomDto(String room_no, Integer chat_member_1, Integer chat_member_2) {
		this.room_no = room_no;
		this.chat_member_1 = chat_member_1;
		this.chat_member_2 = chat_member_2;
	}

	public String getRoom_no() {
		return room_no;
	}

	public void setRoom_no(String room_no) {
		this.room_no = room_no;
	}

	public Integer getChat_member_1() {
		return chat_member_1;
	}

	public void setChat_member_1(Integer chat_member_1) {
		this.chat_member_1 = chat_member_1;
	}

	public Integer getChat_member_2() {
		return chat_member_2;
	}

	public void setChat_member_2(Integer chat_member_2) {
		this.chat_member_2 = chat_member_2;
	}

	@Override
	public String toString() {
		return "ChatRoomDto [room_no=" + room_no + ", chat_member_1=" + chat_member_1 + ", chat_member_2="
				+ chat_member_2 + "]";
	}
}
