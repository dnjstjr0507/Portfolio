package kr.ws.travel.member;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);

	@Autowired
	private MemberDAO memberDAO;
	
	// 회원가입
	public void insert(MemberVO memberVO) {
		memberDAO.insert(memberVO);
	}

	// 레벨 변경
	public void updateLev(String mb_id, int mb_lev) {
		memberDAO.updateLev(mb_id, mb_lev);
	}

	// 키값 저장
	public void updateKey(String mb_email, String mb_key) {
		memberDAO.updateKey(mb_email, mb_key);
	}

	// 키값 얻기
	public String getKey(String mb_email) {
		return memberDAO.getKey(mb_email);
	}
	
	// 비밀번호 찾기 키 저장
	public void updatesetkey(String mb_email, String setkey) {
		memberDAO.updatesetkey(mb_email, setkey);
	}
	
	// 비밀번호 찾기 키 얻기
	public String getsetkey(String mb_email) {
		return memberDAO.getsetkey(mb_email);
	}

	public int logIn(String mb_id, String mb_password) {
		int idcount = memberDAO.getOneId(mb_id);
		if (idcount != 0) {
			int lev = memberDAO.getLev(mb_id);
			String log_password = memberDAO.passwordChek(mb_id);
			if (idcount != 0 && !mb_password.equals(log_password)) {
				return 2;
			} else if (idcount != 0 && mb_password.equals(log_password) && lev == 0) {
				return 3;
			} else if (idcount != 0 && mb_password.equals(log_password) && lev == -1) {
				return 4;
			} else {
				return 5;
			}
		} else {
			return 1;
		}
	}
	
	// 현재비밀번호 체크
	public int ajax_passwordCK(String mb_id, String mb_password) {
		String log_password = memberDAO.passwordChek(mb_id);
		if(mb_password.equals(log_password)) {
			return 1;
		}else {
			return 0;
		}
	}
	
	// 레벨 가져오기
	public int getLev(String mb_id) {
		return memberDAO.getLev(mb_id);
	}
	
	// 아이디 갯수 가져오기
	public int getOneId(String mb_id) {
		return memberDAO.getOneId(mb_id);
	}

	// 이메일 갯수 가져오기
	public int getOneEmail(String mb_email) {
		return memberDAO.getOneEmail(mb_email);
	}

	// 닉네임 갯수 가져오기
	public int getOneNickname(String mb_nickname) {
		return memberDAO.getOneNickname(mb_nickname);
	}

	public MemberVO selectById(String mb_id) {
		return memberDAO.selectById(mb_id);
	}
	
	public String selectByName(String mb_id) {
		return memberDAO.selectByName(mb_id);
	}

	public void updateMember(MemberVO memberVO) {
		memberDAO.updateMember(memberVO);
		String log_password = memberDAO.passwordChek(memberVO.getMb_id());
		String log_nickname = memberDAO.selectByNickname(memberVO.getMb_id());
		if (memberVO.getMb_password().equals(log_password)) {
			if (!memberVO.getMb_nickname().equals(log_nickname)) {
				memberDAO.updateNickname(memberVO.getMb_id(), memberVO.getMb_nickname());
			}
		}
	}
	
	// 아이디 찾기
	public String findid(String mb_name, String mb_email) {
		return memberDAO.findid(mb_name, mb_email);
	}
	

	// 비밀번호 찾기 레벨 권한이 1이상만 찾아주기 -1은 탈퇴한 회원 -2는 차단
	public String findpw(String mb_id, String mb_email) {
		return memberDAO.findpw(mb_id, mb_email);
	}
	
	// 비밀번호 변경
	public void updatePW(String mb_id, String mb_password, String setkey) {
		memberDAO.updatePW(mb_id,mb_password,setkey);
	}
	
	// 비밀번호 바꾸기
	public void updatePassword(String mb_id, String mb_password) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_id", mb_id);
		map.put("mb_password", mb_password);
		memberDAO.updatePassword(map);
	}
	
	// 회원정보 전체 가져오기
	public List<MemberVO> selectMemberAll(){
		return memberDAO.selectMemberAll();
	}
	
	// 닉네임 변경 시간 가져오기
	public long selectNikupdatetime(String mb_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mb_id", mb_id);
		Date nikupdatetime = memberDAO.selectNikupdatetime(map);
		Date sys = memberDAO.sysdate();
		long time = sys.getTime()-nikupdatetime.getTime();
		long timeCk = (time/(24 * 60 * 60 * 1000));
		return timeCk;
	}
	
	// dual 현재 시간 가져오기
	
}
