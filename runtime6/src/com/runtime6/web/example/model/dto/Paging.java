package com.runtime6.web.example.model.dto;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;

@Configurable(preConstruction=true, dependencyCheck=true)
public class Paging {
	
	public Paging(int currPageNo, int totRowCnt){
		this.currPageNo = currPageNo == 0 ? 1 : currPageNo;
		this.totRowCnt = totRowCnt;
	}
	
	//표시할 페이지의 갯수
	@Value("#{runtime6Prop['paging.page.size']}")
	private int pageCnt;
	//페이지당 표시할 행의 갯수
	@Value("#{runtime6Prop['paging.item.size']}")
	private int pageRows;
	//현재 페이지의 번호
	private int currPageNo;
	//전체 로우의 갯수
	private int totRowCnt;
	
	public int getPageRows() {
		return pageRows;
	}

	public int getPageCnt() {
		return pageCnt;
	}

	//첫 페이지의 번호
	public int getFirstPageNo() {
		return 1;
	}
		
	public int getCurrPageNo() {
		return currPageNo;
	}

	//페이지에서의 시작 로우의 번호
	public int getFromRowNum() {
		//현재 페이지가 5페이지라면?
		//41 ~ 50을 얻어야 쿼리를 수행할 수 있다.
		//그러므로 fromRowNum = 51
		return (currPageNo - 1) * pageRows + 1;
	}
	//페이지에서의 끝 로우의 번호
	public int getToRowNum() {
		return currPageNo * pageRows;
	}
	//마지막 페이지의 번호
	public int getLastPageNo() {
		//전체 행의 갯수가 733개라면...
		//733 / 페이지당 행의 수 + (나머지가 있으면 : 1) => 74페이지
		return totRowCnt / pageRows + (totRowCnt % pageRows > 0 ? 1 : 0);
	}
	//이전 페이지의 번호
	public int getPrevPageNo() {
		//현재 페이지가 23페이지라면...
		//이전 페이지는 11을 가르키고 있으면 된다.
		//하지만 현재 페이지가 3페이지라면...
		//이전 페이지는 1페이지를 가르켜야 한다.
		//return (currPageNo - pageCnt) / pageCnt * pageCnt + 1;
		int tmpNo = ((currPageNo / pageCnt) + (currPageNo % pageCnt > 0 ? 1 : 0) - 1) 
				* pageCnt + 1;
		return tmpNo - pageCnt > 0 ? tmpNo - pageCnt : 1;
	}
	//다음 페이지의 번호
	public int getNextPageNo() {
		//현재 페이지가 33페이지이고, 마지막 페이지가 74페이지라면
		//다음 페이지는 41페이지를 가르키면 된다.
		//하지만 현재 페이지가 71페이지라면
		//다음 페이지는 74페이지를 가르켜야 한다.
		if (((getLastPageNo() - currPageNo) / pageCnt) > 0) {
			//return (currPageNo + pageCnt) / pageCnt * pageCnt + 1;
			return ((currPageNo / pageCnt) + (currPageNo % pageCnt > 0 ? 1 : 0) - 1) 
					* pageCnt + 1 + pageCnt;
		} else {
			return getLastPageNo();
		}
	}
}
