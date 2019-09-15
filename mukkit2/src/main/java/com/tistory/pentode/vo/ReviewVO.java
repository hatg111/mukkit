package com.tistory.pentode.vo;

import java.util.Date;

public class ReviewVO {
	private Integer reviewid;
	private String memberid;
	private String reviewlike;
	private String reportreason;
	private Date reportdate;
	private Integer feedbackid;
	private Integer storeid;

	public Integer getReviewid() {
		return reviewid;
	}

	public void setReviewid(Integer reviewid) {
		this.reviewid = reviewid;
	}

	public String getMemberid() {
		return memberid;
	}

	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}

	public String getReviewlike() {
		return reviewlike;
	}

	public void setReviewlike(String reviewlike) {
		this.reviewlike = reviewlike;
	}

	public String getReportreason() {
		return reportreason;
	}

	public void setReportreason(String reportreason) {
		this.reportreason = reportreason;
	}

	public Date getReportdate() {
		return reportdate;
	}

	public void setReportdate(Date reportdate) {
		this.reportdate = reportdate;
	}

	public Integer getFeedbackid() {
		return feedbackid;
	}

	public void setFeedbackid(Integer feedbackid) {
		this.feedbackid = feedbackid;
	}

	public Integer getStoreid() {
		return storeid;
	}

	public void setStoreid(Integer storeid) {
		this.storeid = storeid;
	}

	@Override
	public String toString() {
		return "ReviewVO [reviewid=" + reviewid + ", memberid=" + memberid + ", reviewlike=" + reviewlike
				+ ", reportreason=" + reportreason + ", reportdate=" + reportdate + ", feedbackid=" + feedbackid
				+ ", storeid=" + storeid + "]";
	}

}
