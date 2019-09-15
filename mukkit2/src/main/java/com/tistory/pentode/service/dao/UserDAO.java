package com.tistory.pentode.service.dao;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;

import com.tistory.pentode.vo.UserVO;
import com.tistory.pentode.dto.LoginDTO;

public interface UserDAO {

	public UserVO login(LoginDTO dto) throws Exception;

	public void keepLogin(@Param("uid") String uid, @Param("sessionId") String sessionId, @Param("next") Date next);

	public UserVO checkUserWithSessionKey(String value);

	public UserVO getUserInfo(UserVO vo);

	// 용태님 start 2019-08-09

	public List<UserVO> getUserList() throws Exception;

	public int checkId(String memberid) throws Exception;

	public int checkNickname(String nickname) throws Exception;

	public int checkPwd(@Param("memberid") String memberid, @Param("password") String password) throws Exception;

	public int insertUser(UserVO userVO) throws Exception;
	
	public void insertMemberImg(@Param("memberid") String memberid) throws Exception;

	public int updateUser(UserVO userVO) throws Exception;

	public int deleteUser(String uid) throws Exception;

	public void insertImg(@Param("memberid") String memberid, @Param("fileName") String fileName) throws Exception;

	public String sendmail(String memberid) throws Exception;

	public void findPwd(UserVO userVO) throws Exception;
	// 용태님 end
}
