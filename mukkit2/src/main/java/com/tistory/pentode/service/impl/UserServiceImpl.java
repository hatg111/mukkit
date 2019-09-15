package com.tistory.pentode.service.impl;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tistory.pentode.vo.UserVO;
import com.tistory.pentode.dto.LoginDTO;
import com.tistory.pentode.service.UserService;
import com.tistory.pentode.service.dao.UserDAO;
import com.tistory.pentode.util.MailUtils;
import com.tistory.pentode.util.TempKey;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;

	@Override
	public UserVO login(LoginDTO dto) throws Exception {

		return dao.login(dto);
	}

	@Override
	public void keepLogin(String memberid, String sessionId, Date next) throws Exception {

		dao.keepLogin(memberid, sessionId, next);

	}

	@Override
	public UserVO checkLoginBefore(String value) {

		return dao.checkUserWithSessionKey(value);
	}

	@Override
	public UserVO getUserInfo(UserVO vo) {
		return dao.getUserInfo(vo);
	}

	// 용태님 start 2019-08-09
	@Override
	public List<UserVO> getUserList() throws Exception {
		return dao.getUserList();
	}

	@Override
	public int checkId(String memberid) throws Exception {
		return dao.checkId(memberid);
	}

	@Override
	public void insertUser(UserVO userVO) throws Exception {
		dao.insertUser(userVO);
		/* dao.insertMemberImg(userVO.getMemberid()); */
	}

	@Override
	public void updateUser(UserVO userVO) throws Exception {
		dao.updateUser(userVO);
	}

	@Override
	public void deleteUser(String uid) throws Exception {
		dao.deleteUser(uid);
	}

	@Override
	public void insertImg(String memberid, String fileName) throws Exception {
		dao.insertImg(memberid, fileName);
	}
	// 2019-08-09

	@Override
	public int checkNickname(String nickname) throws Exception {
		return dao.checkNickname(nickname);
	}

	@Override
	public int checkPwd(String memberid, String password) throws Exception {
		// TODO Auto-generated method stub
		return dao.checkPwd(memberid, password);
	}

	@Autowired
	private JavaMailSender mailSender;

	@Override
	@Transactional
	public String sendmail(String memberid) throws Exception {
		// dao.sendmail(memberid);

		System.out.println("임의 키 생성");
		// 임의의 authkey 생성
		String authkey = new TempKey().getKey(10, false);
		System.out.println("authkey: " + authkey);

		// uVO.setAuthkey(authkey);
		// uDAO.updateAuthkey(uVO);

		// mail 작성 관련
		System.out.println("메일 작성");
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("[Mukkit List] 회원가입 이메일 인증");
		sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
				.append("<p>인증번호 입니다.</p><br/>").append(authkey).toString());

		
		  /*.append("<a href='http://localhost:28080/user/sendmail?uid=").append(
		  memberid) .append("&email=") .append(memberid)
		  .append("&authkey=").append(authkey).append("' target='_blank'>이메일 인증 확인</a>"
		  ).toString()); // sendMail.setFrom("wgwdgw@gmail.com", "wgdwdg@gmail.com");*/
		  sendMail.setTo(memberid); 
		  sendMail.send();
		 

		return authkey;
	}

	public String findPwd(UserVO userVO) throws Exception {

		// 임의의 password 생성
		String pwd = new TempKey().getKey(10, false);

		// 임시 비밀번호로 변경
		userVO.setPassword(pwd);
		dao.findPwd(userVO);
		
		return pwd;

		// mail 작성 관련
		/*System.out.println("메일 작성");
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("[Mukkit List] 임시 비밀번호 발급 안내");
		sendMail.setText(new StringBuffer().append("<h1>[임시 비밀번호 발급]</h1>").append("<p>임시 비밀번호 입니다.</p>").toString());
		sendMail.setText(pwd);
		// sendMail.setFrom("mukkit1234@gmail.com", "mukkit1234@gmail.com");
		sendMail.setTo(userVO.getMemberid());
		sendMail.send();
		return pwd;*/
	}

	// 2019-08-09

}
