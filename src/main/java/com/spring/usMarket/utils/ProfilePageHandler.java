package com.spring.usMarket.utils;

public class ProfilePageHandler {
	
	private ProfileSearchCondition sc; // page, pageSize, option
	private int totalCnt;
	
	private int navSize = 10; // 페이지 범위
	private int totalPage;
	private int beginPage;  // 내비게이션의 첫 페이지
    private int endPage;    // 내비게이션의 마지막 페이지
    private boolean showPrev;   // 이전 페이지 표시 여부
    private boolean showNext;   // 다음 페이지 표시 여부
    
    
    public ProfilePageHandler(int totalCnt, ProfileSearchCondition sc) {
    	this.totalCnt = totalCnt;
    	this.sc = sc;
    	
    	doPaging(totalCnt, sc);
    }
    
    
    public void doPaging(int totalCnt, ProfileSearchCondition sc) {
        this.totalCnt = totalCnt;
        this.sc=sc;

        totalPage = (int)Math.ceil(totalCnt/(double)sc.getPageSize());
        beginPage = (sc.getPage()-1)/navSize*navSize+1;
        endPage = Math.min(beginPage+navSize-1, totalPage);

        showPrev = beginPage != 1;
        showNext = endPage != totalPage;
    }
    
    
    public void print(){
        System.out.println("page= "+sc.getPage());
        System.out.print(showPrev?"[PREV] " : "");
        for (int i = beginPage; i <= endPage ; i++) {
            System.out.print(i+" ");
        }
        System.out.print(showNext?"[NEXT]\n" : "\n");
    }
    
    
	public ProfileSearchCondition getSc() {
		return sc;
	}

	public void setSc(ProfileSearchCondition sc) {
		this.sc = sc;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public int getNavSize() {
		return navSize;
	}

	public void setNavSize(int navSize) {
		this.navSize = navSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getBeginPage() {
		return beginPage;
	}

	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isShowPrev() {
		return showPrev;
	}

	public void setShowPrev(boolean showPrev) {
		this.showPrev = showPrev;
	}

	public boolean isShowNext() {
		return showNext;
	}

	public void setShowNext(boolean showNext) {
		this.showNext = showNext;
	}

	@Override
	public String toString() {
		return "PageHandler [sc=" + sc + ", totalCnt=" + totalCnt + ", navSize=" + navSize + ", totalPage=" + totalPage
				+ ", beginPage=" + beginPage + ", endPage=" + endPage + ", showPrev=" + showPrev + ", showNext="
				+ showNext + "]";
	}
}
