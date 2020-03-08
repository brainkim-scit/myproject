package com.mynameis.first.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class mapAPI {

	private static final Logger logger = LoggerFactory.getLogger(mapAPI.class);

	@RequestMapping(value = "/kakaoMap", method = RequestMethod.GET, produces = "application/text;charset=utf-8")
	public String mapOutput(String address) throws ServletException, IOException {
		logger.info("지도 출력 : " + address);
		StringBuilder urlBuilder = new StringBuilder("https://developers.kakao.com/docs/restapi/local/search/address.json");
		urlBuilder.append("?" + URLEncoder.encode("Authorization: ", "UTF-8")+ "a2bbbdbc5a127ee61e35fd3dd4e3dd77");
		urlBuilder.append("&" + URLEncoder.encode("query", "UTF-8") + "=" + URLEncoder.encode(address, "UTF-8"));

		URL url = new URL(urlBuilder.toString());

		HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
		urlconnection.setRequestMethod("GET");
		BufferedReader br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));
		String result = "";
		String line;
		while ((line = br.readLine()) != null) {
			result = result + line + "\n";
		}
		logger.info("지도 데이터 요청 주소 : " + urlBuilder.toString());
		logger.info("지도 결과 : " + result);

		return result;
	}
}