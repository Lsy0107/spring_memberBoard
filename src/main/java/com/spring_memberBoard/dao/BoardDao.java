package com.spring_memberBoard.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.spring_memberBoard.dto.Boards;
import com.spring_memberBoard.dto.Replys;

public interface BoardDao {
	
	@Insert("INSERT INTO BOARDS(BNO,BWRITER,BTITLE,BCONTENTS,BHITS,BDATE,BFILENAME,BSTATE) VALUES(#{bno},#{bwriter},#{btitle},#{bcontents},0,SYSDATE,#{bfilename} ,'1')")
	int UploadDao(Boards board);

	@Select("SELECT NVL(MAX(BNO),0) FROM BOARDS")
	int selectBno();

	@Select("SELECT BNO,BTITLE,BWRITER,BDATE,BHITS,BFILENAME FROM BOARDS WHERE BSTATE = '1'")
	ArrayList<Boards> SelBoardList();

	@Select("SELECT * FROM BOARDS WHERE BNO=#{bno}")
	Boards BoardViewDao(Boards board);

	@Update("UPDATE BOARDS SET BHITS = BHITS + 1 WHERE BNO = #{bno}")
	int BoardHitsDao(Boards board);

	@Select("SELECT * FROM BOARDS WHERE BNO=#{bno}")
	Boards BoardFixDao(Boards board);

	@Update("UPDATE BOARDS SET BCONTENTS=#{bcontents},BTITLE=#{btitle} WHERE BNO=#{bno}")
	int BoardFixComDao(Boards board);

	@Select("SELECT NVL(MAX(RENUM),0) FROM REPLYS")
	int selectReNum(Replys replys);

	@Insert("INSERT INTO REPLYS(RENUM,REBNO,REMID,RECOMMENT,REDATE,RESTATE) VALUES(#{renum},#{rebno},#{remid},#{recomment},SYSDATE,'1')")
	int SendCommentDao(Replys replys);

	@Select("SELECT * FROM REPLYS WHERE REBNO = #{rebno} AND RESTATE = '1' ORDER BY REDATE")
	ArrayList<Replys> getReplyDao(int rebno);
	
	@Update("UPDATE REPLYS SET RESTATE = '0' WHERE RENUM = #{renum}")
	int deleteReply(@Param("renum") int renum);

	@Select("SELECT COUNT(*) FROM REPLYS WHERE REBNO = #{bno} AND RESTATE = '1'")
	int selectBoardReount(@Param("bno") int bno);

	@Select("SELECT B.*,NVL(R.RECOUNT,0) AS RECOUNT FROM BOARDS B LEFT OUTER JOIN (SELECT REBNO,COUNT(REBNO) AS RECOUNT FROM REPLYS WHERE RESTATE = '1' GROUP BY REBNO) R ON B.BNO = R.REBNO WHERE B.BSTATE = '1' ORDER BY B.BDATE DESC")
	ArrayList<HashMap<String, String>> selectBoards_map();

	


}
