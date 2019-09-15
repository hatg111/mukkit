package com.tistory.pentode.service;

import java.util.List;

import com.tistory.pentode.domain.SearchCriteria;
import com.tistory.pentode.vo.Criteria;
import com.tistory.pentode.vo.FeedbackVO;
import com.tistory.pentode.vo.MainVO;
import com.tistory.pentode.vo.ReviewVO;

public interface DtpageService {
	List<MainVO> selectDtpageList(Integer storeid) throws Exception;

	List<FeedbackVO> selectFeedbackList(Integer storeid) throws Exception;
	
	/*public List<FeedbackVO> listCriteria(Criteria cri) throws Exception;*/
	
	public List<FeedbackVO> listPage(Criteria cri) throws Exception;
	
	public int listCountCriteria(Criteria cri) throws Exception;
	
	public void reviewdelete(FeedbackVO vo) throws Exception;

	// 댓글 작성
	public int commentInsert(ReviewVO reviewvo) throws Exception;
	 
	// 댓글 리스트
	public List<ReviewVO> commentList(ReviewVO reviewvo) throws Exception;
	
}
