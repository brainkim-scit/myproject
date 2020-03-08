package com.mynameis.first.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class myMemberVO {
	private int memberno;
	private String email;
	private String username;
	private String pw;
	private String address;
	private String sido;
	private String sigungu;
	private String sidocode;
	private String sigungucode;
}
