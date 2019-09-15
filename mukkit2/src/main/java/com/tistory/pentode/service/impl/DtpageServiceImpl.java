package com.tistory.pentode.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tistory.pentode.service.DtpageService;
import com.tistory.pentode.service.dao.DtpageDAO;
import com.tistory.pentode.vo.Criteria;
import com.tistory.pentode.vo.FeedbackVO;
import com.tistory.pentode.vo.MainVO;
import com.tistory.pentode.vo.ReviewVO;

@Service("dtpageService")
public class DtpageServiceImpl implements DtpageService {
	@Autowired
	private DtpageDAO dtpageMapper;

	@Override
	@Transactional
	public List<MainVO> selectDtpageList(Integer storeid) throws Exception {
		System.out.println("DAO의 selectDtpageList 메소드 실행");
		return dtpageMapper.selectDtpageList(storeid);

		// 원래는 DAO를 구현한 클래스에 정의된 메소드를 통해서 가는건데
		// 여기서는 DAO구현 클래스 없이 알아서 메소드 이름과 같은 매퍼파일을 찾아서 간다. (Tb_Board_SQL.xml)
	}

	@Override
	public List<FeedbackVO> selectFeedbackList(Integer storeid) throws Exception {
		// TODO Auto-generated method stub
		return dtpageMapper.selectFeedbackList(storeid);
	}

	@Override
	public void reviewdelete(FeedbackVO vo) throws Exception {
		dtpageMapper.reviewdelete(vo);

	}
/*
	@Override
	public List<FeedbackVO> listCriteria(Criteria cri) throws Exception {

		// TODO Auto-generated method stub
		return dtpageMapper.listCriteria(cri);
	}
*/
	
	
	@Override
	public int listCountCriteria(Criteria cri) throws Exception {

		return dtpageMapper.countPaging(cri);
	}

	@Override
	public int commentInsert(ReviewVO reviewvo) throws Exception {
		// TODO Auto-generated method stub
		return dtpageMapper.commentInsert(reviewvo);
	}

	@Override
	public List<ReviewVO> commentList(ReviewVO reviewvo) throws Exception {
		// TODO Auto-generated method stub
		return dtpageMapper.commentList(reviewvo);
	}

	@Override
	public List<FeedbackVO> listPage(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dtpageMapper.listPage(cri);
	}




}
