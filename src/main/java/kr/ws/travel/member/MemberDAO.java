package kr.ws.travel.member;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSession sqlSession;

	public void insert(MemberVO vo) {
		sqlSession.insert("member.insert", vo);
	}

	// 아이디 일치하는게 있는지 0이면 없음 1이면 존재
	public int getOneId(String mb_id) {
		return sqlSession.selectOne("member.getOneId", mb_id);
	}

	// 이메일 갯수 가져오기
	public int getOneEmail(String mb_email) {
		return sqlSession.selectOne("member.getOneEmail", mb_email);
	}

	// 닉네임 갯수 가져오기
	public int getOneNickname(String mb_nickname) {
		return sqlSession.selectOne("member.getOneNickname", mb_nickname);
	}

	// 레벨 가져오기
	public int getLev(String mb_id) {
		return sqlSession.selectOne("member.getLev", mb_id);
	}

	// 아이디 정보 가져오기
	public MemberVO selectById(String mb_id) {
		return sqlSession.selectOne("member.selectById", mb_id);
	}

	// 비밀번호 체크
	public String passwordChek(String mb_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_id", mb_id);
		return sqlSession.selectOne("member.passwordChek", map);
	}

	// 회원정보 수정
	public void updateMember(MemberVO vo) {
		sqlSession.update("member.updateMember", vo);
	}

	// 닉네임 변경
	public void updateNickname(String mb_id, String mb_nickname) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_id", mb_id);
		map.put("mb_nickname", mb_nickname);
		sqlSession.update("member.updateNickname", map);
	}

	// 닉네임 가져오기
	public String selectByNickname(String mb_id) {
		return sqlSession.selectOne("member.selectByNickname", mb_id);
	}
	
	// 이름 가져오기
	public String selectByName(String mb_id) {
		return sqlSession.selectOne("member.selectByName", mb_id);
	}

	// 레벨 변경 (미인증0, 인증1, 탈퇴 -1, 차단-2, 최고관리자 99)
	public void updateLev(String mb_id, int mb_lev) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_id", mb_id);
		map.put("mb_lev", mb_lev + "");
		sqlSession.update("member.updatelev", map);
	}

	// 키 저장
	public void updateKey(String mb_email, String mb_key) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_email", mb_email);
		map.put("mb_key", mb_key);
		sqlSession.update("member.updatekey", map);
	}

	// 키읽어오기
	public String getKey(String mb_email) {
		return sqlSession.selectOne("member.getKey", mb_email);
	}

	// 아이디 찾기
	public String findid(String mb_name, String mb_email) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_name", mb_name);
		map.put("mb_email", mb_email);
		return sqlSession.selectOne("member.findid", map);
	}
	
	// 비밀번호 찾기 
	public String findpw(String mb_id, String mb_email) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_id", mb_id);
		map.put("mb_email", mb_email);
		return sqlSession.selectOne("member.findpw", map);
	}
	
	// 비밀번호 가져오기
	public String passwordCk(String mb_password) {
		return sqlSession.selectOne("member.passwordCk", mb_password);
	}
	
	// 비밀번호 변경
	public void updatePW(String mb_id, String mb_password, String setkey) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_id", mb_id);
		map.put("mb_password", mb_password);
		map.put("setkey", setkey);
		sqlSession.update("member.updatePW", map);
	}
	
	// 비밀번호 찾기 키 저장
	public void updatesetkey(String mb_id, String setkey) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_id", mb_id);
		map.put("setkey", setkey);
		sqlSession.update("member.updatesetkey", map);
	}

	// 비밀번호 찾기 키읽어오기
	public String getsetkey(String mb_id) {
		return sqlSession.selectOne("member.getsetkey", mb_id);
	}
	
	// 비밀번호 바꾸기
	public void updatePassword(HashMap<String, String> map) {
		sqlSession.update("member.updatePassword", map);
	}
	
	// 회원정보 전체 가져오기
	public List<MemberVO> selectMemberAll(){
		return sqlSession.selectList("member.selectMemberAll");
	}
	
	// 닉네임 업데이트 시간 가져오기
	public Date selectNikupdatetime(HashMap<String, String> map) {
		return sqlSession.selectOne("member.selectNikupdatetime", map);
	}
	
	// dual 현재 시간 가져오기
	public Date sysdate() {
		return sqlSession.selectOne("member.sysdate");
	}

}
