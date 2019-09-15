package com.tistory.pentode.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.tistory.pentode.vo.UserVO;
import com.tistory.pentode.dto.LoginDTO;

public interface UserService {

	public UserVO login(LoginDTO dto) throws Exception;

	public void keepLogin(String memberid, String sessionId, Date next) throws Exception;

	public UserVO checkLoginBefore(String value);

	public UserVO getUserInfo(UserVO vo);

	// 용태님 start 2019-08-09
	public List<UserVO> getUserList() throws Exception;

	public int checkId(String memberid) throws Exception;

	public int checkNickname(String nickname) throws Exception;

	public int checkPwd(String memberid, String password) throws Exception;

	public void insertUser(UserVO userVO) throws Exception;

	public void updateUser(UserVO userVO) throws Exception;

	public void deleteUser(String uid) throws Exception;

	public void insertImg(String memberid, String fileName) throws Exception;

	public String findPwd(UserVO userVO) throws Exception;

	public String sendmail(String memberid) throws Exception;

	// 용태님 end
}
