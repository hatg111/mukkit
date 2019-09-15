package com.tistory.pentode;

import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tistory.pentode.service.StoreService;
import com.tistory.pentode.vo.FeedbackVO;
import com.tistory.pentode.vo.StoreVO;

@Controller
public class StoreController {

	@Resource(name = "storeService")
	private StoreService storeService;

	private static final Logger logger = LoggerFactory.getLogger(StoreController.class);

	@RequestMapping(value = "/storeranking")
	public String storeranking(@RequestParam(value = "sorted", required = false) String sorted, Model model)
			throws Exception {

		List<StoreVO> list = storeService.selectStoreL(sorted);

		logger.info(list.toString());

		model.addAttribute("storelist", list);
		model.addAttribute("select", sorted);

		return "storeranking/storeranking";

	}

	@RequestMapping(value = "/storelistA")
	public String storelistA(@RequestParam(value = "sorted", required = false) String sorted, Model model)
			throws Exception {

		List<StoreVO> list = storeService.selectStoreListA(sorted);

		logger.info(list.toString());

		model.addAttribute("storelist", list);

		return "storeranking/storerankingA";

	}

	@RequestMapping(value = "/storelistB")
	public String storelistB(@RequestParam(value = "sorted", required = false) String sorted, Model model)
			throws Exception {

		List<StoreVO> list = storeService.selectStoreListB(sorted);

		logger.info(list.toString());

		model.addAttribute("storelist", list);

		return "storeranking/storerankingB";

	}

	@RequestMapping(value = "/storelistC")
	public String storelistC(@RequestParam(value = "sorted", required = false) String sorted, Model model)
			throws Exception {

		List<StoreVO> list = storeService.selectStoreListC(sorted);

		logger.info(list.toString());

		model.addAttribute("storelist", list);

		return "storeranking/storerankingC";

	}

	@RequestMapping(value = "/storelistD")
	public String storelistD(@RequestParam(value = "sorted", required = false) String sorted, Model model)
			throws Exception {

		List<StoreVO> list = storeService.selectStoreListD(sorted);

		logger.info(list.toString());

		model.addAttribute("storelist", list);

		return "storeranking/storerankingD";

	}

	@RequestMapping(value = "/storelistE")
	public String storelistE(@RequestParam(value = "sorted", required = false) String sorted, Model model)
			throws Exception {

		List<StoreVO> list = storeService.selectStoreListE(sorted);

		logger.info(list.toString());

		model.addAttribute("storelist", list);

		return "storeranking/storerankingE";

	}

	@RequestMapping(value = "/storebycategory")
	public String storelisttaste(Model model) throws Exception {

		/*
		 * List<StoreVO> list = storeService.selectStoreListTaste();
		 * 
		 * logger.info(list.toString());
		 * 
		 * model.addAttribute("storelist", list);
		 */

		return "storeranking/storelistbycategory";

	}
	

	// store별 평균 점수 업데이트 url로 하나씩 하는거
	/*@RequestMapping(value = "/starUpdate", method = RequestMethod.GET)
	public String starUpdate(@RequestParam("storeid") Integer storeid, StoreVO storeStarAvg) throws Exception {
		// controller에 피드백 테이블에서 storeid로 조회해서 avg평균을 구해서 vo에 담고
		// 해당 storeid 조건으로 update 한다.
		System.out.println("starUpdate 컨트롤러 storeid: " + storeid);
		storeStarAvg = storeService.starAvarage(storeid);
		//feedback점수를 스토어별로 평균내서 store_tbl에 넣기

		logger.info("맛점수 : " + storeStarAvg.getTastestar() + "가성비점수 : " + storeStarAvg.getCostefstar() + "서비스점수 : "
				+ storeStarAvg.getServicestar());

		int tasteStar = storeStarAvg.getTastestar();
		int costefStar = storeStarAvg.getCostefstar();
		int serviceStar = storeStarAvg.getServicestar();
		int star = (tasteStar + costefStar + serviceStar) / 3;

		storeService.updateStarAvarage(tasteStar, costefStar, serviceStar, storeid, star);

		return "test";
	}*/

	// store별 평균 점수 업데이트 url로 전체 하는거
	@RequestMapping(value = "/starUpdateAll", method = RequestMethod.GET)
	public String starUpdateAll() throws Exception {
		Integer storeid;
		List<StoreVO> list = storeService.selectStoreIdList();

		for (StoreVO storevo : list) {
			storeid = storevo.getStoreid();
			System.out.println("storeid: " + storeid);

			StoreVO storeStarAvg = storeService.starAvarage(storeid);
			//feedback점수를 스토어별로 평균내서 storevo에 저장

			/*
			 * logger.info("맛점수 : " + storeStarAvg.getTastestar() + "가성비점수 : " +
			 * storeStarAvg.getCostefstar() + "서비스점수 : " + storeStarAvg.getServicestar());
			 */
			
			int tasteStar = storeStarAvg.getTastestar();
			int costefStar = storeStarAvg.getCostefstar();
			int serviceStar = storeStarAvg.getServicestar();
			int star = (tasteStar + costefStar + serviceStar) / 3;

			storeService.updateStarAvarage(tasteStar, costefStar, serviceStar, storeid, star);
			
		}

		return "test";
	}

	// 자동으로 storeid 구해서 업데이트하는거
	// 1초마다 호출 1000
	// 1시간마다 호출 60 * 60 * 1000
	// 하루에 한번 24 * 60 * 60 * 1000
	/*@Scheduled(fixedDelay = 60 * 60 * 1000)
	public void storeAvgUpdate() throws Exception {
		Integer storeid;
		List<StoreVO> list = storeService.selectStoreIdList();

		for (StoreVO storevo : list) {
			storeid = storevo.getStoreid();
			System.out.println("storeid: " + storeid);

			StoreVO storeStarAvg = storeService.starAvarage(storeid);

			
			 * logger.info("맛점수 : " + storeStarAvg.getTastestar() + "가성비점수 : " +
			 * storeStarAvg.getCostefstar() + "서비스점수 : " + storeStarAvg.getServicestar());
			 

			float tasteStar = storeStarAvg.getTastestar();
			float costefStar = storeStarAvg.getCostefstar();
			float serviceStar = storeStarAvg.getServicestar();
			float star = (tasteStar + costefStar + serviceStar) / 3;

			storeService.updateStarAvarage(tasteStar, costefStar, serviceStar, storeid, star);
		}

		System.out.println(new Date() + "스케줄링 별점 업데이트 처리완료");

	}*/

}
