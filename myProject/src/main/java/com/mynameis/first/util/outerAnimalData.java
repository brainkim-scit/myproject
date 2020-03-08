package com.mynameis.first.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mynameis.first.dao.member.memberDAO;

@RestController
public class outerAnimalData {

	private static final Logger logger = LoggerFactory.getLogger(outerAnimalData.class);

	@Autowired
	memberDAO mdao;

	public String[] dateSet() {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String[] range = new String[2];
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, -6);
		range[0] = dateFormat.format(date);
		range[1] = dateFormat.format(cal.getTime());
		logger.info("시작날짜 범위 : " + range[0] + "~" + range[1]);
		return range;
	}

	@RequestMapping(value = "/outerAnimaldata", method = RequestMethod.GET, produces = "application/text;charset=utf-8")
	public String dataOutput(String dateSelect, String type, String pagenum, String sidocode, String sigungucode,
			HttpSession session) throws ServletException, IOException {
		logger.info("outer 데이터 출력 시작 조건 : " + "날짜/" + dateSelect + " 타입/" + type + " 페이지번호/" + pagenum + " 시도코드/"
				+ sidocode + " 시군구코드/" + sigungucode);
		String[] set = dateSet();

		if ((sidocode == null && sigungucode == null)) {
			if ((session.getAttribute("sidocode") == null && session.getAttribute("sigungucode") == null)) {
				if (dateSelect == null) {
					return "no";
				} else {
					return "no";
				}
			} else {
				sidocode = (String) session.getAttribute("sidocode");
				sigungucode = (String) session.getAttribute("sigungucode");
			}
		} else if (sidocode != null && sigungucode == null) {
			session.setAttribute("sidocode", sidocode);
			sidocode = (String) session.getAttribute("sidocode");
			sigungucode = "";
		}else if (sidocode.equals("1") && sigungucode.equals("1")) {
			session.removeAttribute("sidocode");
			session.removeAttribute("sigungucode");
			return "no";
		} else {
			session.setAttribute("sigungucode", sigungucode);
			session.setAttribute("sidocode", sidocode);
		}

		if (dateSelect == null && session.getAttribute("date") == null) {
			dateSelect = set[1];
		} else if (dateSelect != null) {
			session.setAttribute("date", dateSelect);
			logger.info("날짜 세션 세팅 : " + (String) session.getAttribute("date"));
		} else if (dateSelect == null && session.getAttribute("date") != null) {
			dateSelect = (String) session.getAttribute("date");
		}

		if (pagenum == null && session.getAttribute("page") == null) {
			pagenum = "1";
		} else if (pagenum != null) {
			session.setAttribute("page", pagenum);
			logger.info("페이지 세션 세팅 : " + (String) session.getAttribute("page"));
		} else if (pagenum == null && session.getAttribute("page") != null) {
			pagenum = (String) session.getAttribute("page");
		}

		StringBuilder urlBuilder = new StringBuilder(
				"http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic");
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8")
				+ "=mTb7y%2F%2BslyOYTh4sTg5%2Fajkb9VUd0B9jUaQPEIngD92L5sWXcyMyQBTNMnlraYwtylHLs2kimbJXgtsNaHr09A%3D%3D");
		urlBuilder.append("&" + URLEncoder.encode("bgnde", "UTF-8") + "=" + URLEncoder.encode(dateSelect, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("endde", "UTF-8") + "=" + URLEncoder.encode(set[0], "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("upr_cd", "UTF-8") + "=" + URLEncoder.encode(sidocode, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("org_cd", "UTF-8") + "=" + URLEncoder.encode(sigungucode, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("upkind", "UTF-8") + "=" + URLEncoder.encode(type, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(pagenum, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("6", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));

		URL url = new URL(urlBuilder.toString());

		HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
		urlconnection.setRequestMethod("GET");
		BufferedReader br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));
		String result = "";
		String line;
		while ((line = br.readLine()) != null) {
			result = result + line + "\n";
		}
		logger.info("유기동물 데이터 요청 주소 : " + urlBuilder.toString());
		logger.info("요청 결과 : " + result);

		return result;
	}
}