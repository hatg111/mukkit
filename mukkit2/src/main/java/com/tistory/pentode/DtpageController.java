package com.tistory.pentode;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tistory.pentode.service.MukkitService;
import com.tistory.pentode.service.StoreinsertService;
import com.tistory.pentode.vo.MukkitVO;
import com.tistory.pentode.vo.ReviewVO;
import com.tistory.pentode.vo.StoreVO;
import com.tistory.pentode.vo.UserVO;
import com.tistory.pentode.vo.Criteria;
import com.tistory.pentode.vo.PageMaker;
import com.tistory.pentode.domain.SearchCriteria;
import com.tistory.pentode.service.DtpageService;
import com.tistory.pentode.service.MainService;
import com.tistory.pentode.vo.AttachreviewimgVO;
import com.tistory.pentode.vo.FeedbackVO;
import com.tistory.pentode.vo.MainVO;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/main/*")
public class DtpageController {

	@Inject
	private DtpageService service;

	private static final Logger logger = LoggerFactory.getLogger(DtpageController.class);

	@Resource(name = "StoreinsertDAO")
	private StoreinsertService sinsertservice;

	@RequestMapping(value = "storeinsert", method = RequestMethod.GET)
	public void registerGET(StoreVO in, Model model) throws Exception {
		logger.info("register get ...........");
	}

	
	//맛집 정보 추가(url로 접근하도록 하자)
	@RequestMapping(value = "storeinsert", method = RequestMethod.POST)
	public String registPOST(@ModelAttribute("StoreVO") StoreVO StoreVO, Model model, RedirectAttributes rttr) throws Exception {
		logger.info("register post ...........");
		sinsertservice.storeinsert(StoreVO);
		return "/main/insertsuccess";
	}
	/*@RequestMapping(value = "dtpage", method = RequestMethod.GET)
	public String dtpageSearch(@ModelAttribute("Scri") SearchCriteria Scri){
		
		
	}*/
	
	@RequestMapping(value = "dtpage", method = RequestMethod.GET)
	public String registerGET(@RequestParam("storeid") Integer storeid, MainVO mainvo, AttachreviewimgVO reviewimg,
			@ModelAttribute("cri") Criteria cri, Integer reviewid, ReviewVO reviewvo, Model model, FeedbackVO feedbackvo, UserVO uservo, HttpSession session)
			throws Exception {

		session.getAttribute("login");
		uservo = (UserVO) session.getAttribute("login");
		/* logger.info(uservo.toString()); */

		List<MainVO> main = service.selectDtpageList(storeid);
		List<FeedbackVO> list = service.selectFeedbackList(storeid);
		logger.info(list.toString());
		cri.setStoreid(storeid);
		/*logger.info(cri.toString());*/
		model.addAttribute("listAll", service.listPage(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		// pageMaker.setTotalCount(131);
		pageMaker.setTotalCount(service.listCountCriteria(cri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("reviewid", reviewid);
		
		if (uservo != null) {
			model.addAttribute("userVO", uservo);
		}
		model.addAttribute("storeid", storeid);
		model.addAttribute("main", main);
		model.addAttribute("list", list);

		return "/main/dtpage";

	}

	@RequestMapping(value = "/dtpage", method = RequestMethod.POST)
	public String registerReply(ReviewVO reviewvo, @RequestParam("storeid") Integer storeid, Model model, UserVO uservo,
			HttpSession session) throws Exception {
		UserVO member = (UserVO)session.getAttribute("login");
		reviewvo.setMemberid(member.getMemberid());
		service.commentInsert(reviewvo);
		return "redirect:/main/dtpage?storeid=" + reviewvo.getStoreid();
	}

}
