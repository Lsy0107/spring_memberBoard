package com.spring_memberBoard.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.spring_memberBoard.dto.Boards;
import com.spring_memberBoard.dto.Member;
import com.spring_memberBoard.dto.Replys;

public interface MemberDao {

	@Select("SELECT * FROM MEMBERS WHERE MID = #{inputId}")
	Member selectMemberInfo(String inputId);

/*	@Select("SELECT * FROM MEMBERS WHERE MID = #{inputId} AND MPW = #{inputPw]")
	Member selectMemberLogin(@Param("mid") String inputId,@Param("inputPw") String inputPw); //2개 이상의 매개변수가 있을때 */

	Member selectMemberInfo_mapper(@Param("inputId") String inputId);

	@Insert("INSERT INTO MEMBERS(MID,MPW,MNAME,MBIRTH,MEMAIL,MSTATE) VALUES(#{mid},#{mpw},#{mname},#{mbirth},#{memail},'1')")
	int insertMember(Member member);

	@Select("SELECT MID,MPW FROM MEMBERS WHERE MID= #{mid} AND MPW= #{mpw}")
	Member loginMember(@Param("mid") String mid, @Param("mpw") String mpw);

	@Select("SELECT MID,MPW,MNAME,TO_CHAR(MBIRTH,'YYYY-MM-DD') AS MBIRTH,MEMAIL FROM MEMBERS WHERE MID=#{mid}")
	Member ViewMyDaoInfo(Member member);

	@Update("UPDATE MEMBERS SET MPW = #{mpw},MNAME=#{mname},MBIRTH=#{mbirth},MEMAIL=#{memail} WHERE MID = #{mid}")
	int UpdatePw(Member member);

	@Select("SELECT COUNT(*) FROM REPLYS WHERE REMID = #{remid}")
	String ReplyCountDao(Replys reply);

	@Select("SELECT COUNT(*) FROM BOARDS WHERE BWRITER = #{bwriter}")
	String BoardCountDao(Boards board);
}
