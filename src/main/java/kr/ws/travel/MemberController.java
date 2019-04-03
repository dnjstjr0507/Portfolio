package kr.ws.travel;

import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ws.travel.history.HistoryService;
import kr.ws.travel.member.MemberService;
import kr.ws.travel.member.MemberVO;
import kr.ws.travel.menu.MenuService;
import kr.ws.travel.menu.MenuVO;
import kr.ws.travel.util.ClientUtils;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private HistoryService historyService;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	private MenuService menuService;

	// 회원가입 창
	@RequestMapping(value = "join")
	public String insert(Model model) {
		List<List<MenuVO>> mlist = menuService.listoflist();
 		model.addAttribute("mlist",mlist);
		return "index/member/join";
	}

	// 회원가입 로직
	@RequestMapping(value = "joinOK")
	public String insertOK(@ModelAttribute final MemberVO memberVO) {
		if (memberVO != null) {
			memberService.insert(memberVO); // 저장
			// 이메일 발송
			MimeMessagePreparator preparator = new MimeMessagePreparator() {

				@Override
				public void prepare(MimeMessage mimeMessage) throws Exception {
					mimeMessage.setFrom("dnjstjr0507@naver.com");
					mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(memberVO.getMb_email()));
					mimeMessage.setSubject(memberVO.getMb_name() + "님 회원가입을 축하드립니다.");
					String mb_key = "";
					for (int i = 0; i < 10; i++)
						mb_key += (char) ('a' + new Random().nextInt(26)); // 영문자로 10글자 생성
 
					memberService.updateKey(memberVO.getMb_email(), mb_key); // 키를 디비에 저장

					StringBuffer sb = new StringBuffer();
					final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8"); // true (html태그 사용 가능하게)	// "UTF-8"(UTF-8로 인코딩)
					sb.append(memberVO.getMb_name() + "님 회원가입을 축하드립니다.<br>");
					sb.append("링크를 클릭하여 이메일 인증을 하셔야 Travel 커뮤니티에 이용이 가능합니다.<br>");
					helper.setText(
							sb.append("<a href='http://localhost:8080/travel/confirm?mb_key=").append(mb_key)
									.append("&mb_email=").append(memberVO.getMb_email()).append("&mb_id=")
									.append(memberVO.getMb_id()).append("' target='_blank'>이메일 인증 확인</a>").toString(),
							true);
				} 
			};
			mailSender.send(preparator);
		}
		return "redirect:/";
	}

	// 이메일 인증 확인
	@RequestMapping(value = "confirm", method=RequestMethod.GET)
	public String confirm(@RequestParam String mb_key, @RequestParam String mb_email, @RequestParam String mb_id, Model model) {
		String confirm = memberService.getKey(mb_email);
		if (confirm != null && confirm.equals(mb_key)) {
			memberService.updateLev(mb_id, 1);
			memberService.updateKey(mb_email, "");
		}
		
		List<List<MenuVO>> mlist = menuService.listoflist();
 		model.addAttribute("mlist",mlist);
		return "redirect:/";
	}

	// 로그인
	@RequestMapping(value = "signin")
	public String signin(Model model, HttpServletRequest request, HttpSession session) {
		String referer = "";
		if (request.getParameter("referer") == null) {
			referer = request.getHeader("referer");
		} else {
			referer = request.getParameter("referer");
		}
		if (referer == null || referer.trim().length() == 0) {
			referer = request.getContextPath() + "";
		}
		
		MemberVO vo = (MemberVO) session.getAttribute("vo");
		
		List<List<MenuVO>> mlist = menuService.listoflist();
 		model.addAttribute("mlist",mlist);
		model.addAttribute("prevUrl", referer);
		model.addAttribute("result", request.getParameter("result"));
		model.addAttribute("resultMessage", request.getParameter("resultMessage"));
		if(vo != null) {
			return "redirect:/";
		}else {
			return "index/member/signin";
		}
	}

	// 로그인 아이디 비밀번호 체크 로직
	@RequestMapping(value = "signinOK")
	public String signinOK(@RequestParam String mb_id,@RequestParam String mb_password, HttpSession session, HttpServletRequest request) {
		int result = memberService.logIn(mb_id, mb_password);
		String hs_ip = ClientUtils.getRemoteIP(request);
		if (result == 5) {
			MemberVO vo = memberService.selectById(mb_id);
			historyService.insertHistory(mb_id, hs_ip);
			session.setAttribute("vo", vo);
			return "redirect:/";
		} else {
			return "redirect:/signin?result=" + result;
		}
	}
	
	@RequestMapping(value="passwordChek")
	@ResponseBody
	public String passwordChek(HttpSession session, @RequestParam String mb_password) {
		MemberVO vo = (MemberVO)session.getAttribute("vo");
		 return memberService.ajax_passwordCK(vo.getMb_id(), mb_password)+"";
	}
	
	@RequestMapping(value = "getOneId")
	@ResponseBody
	public String getOneId(@RequestParam String mb_id) {
		return memberService.getOneId(mb_id) + "";
	}
	
	@RequestMapping(value = "getOneEmail")
	@ResponseBody
	public String getOneEmail(@RequestParam String mb_email) {
		return memberService.getOneEmail(mb_email) + "";
	}
	
	@RequestMapping(value = "getOneNickname")
	@ResponseBody
	public String getOneNickname(@RequestParam String mb_nickname) {
		return memberService.getOneNickname(mb_nickname) + "";
	}

	@RequestMapping(value = "logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "updateMember")
	public String updateMember(HttpSession session, Model model) {
		MemberVO vo = (MemberVO) session.getAttribute("vo");
		long updateTime = memberService.selectNikupdatetime(vo.getMb_id());
		List<List<MenuVO>> mlist = menuService.listoflist();
 		model.addAttribute("mlist",mlist);
		model.addAttribute("vo", vo);
		model.addAttribute("updateTime", updateTime);
		if(vo != null) {
			return "index/mypage/updateMember";
		}else {
			return "redirect:/";
		}
	}

	@RequestMapping(value = "updateMemberOk")
	public String updateMemberOk(@ModelAttribute MemberVO memberVO, HttpSession session) {
		MemberVO vo = (MemberVO)session.getAttribute("vo");
		memberVO.setMb_password(vo.getMb_password());
		memberService.updateMember(memberVO);
		return "redirect:/";
	}

	@RequestMapping(value="deleteMember")
	public String deleteMember(HttpSession session, Model model) {
		MemberVO vo = (MemberVO)session.getAttribute("vo");
		List<List<MenuVO>> mlist = menuService.listoflist();
		model.addAttribute("mlist",mlist);
		if(vo!=null) {
			return "index/mypage/deleteMember";
		}else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value = "deleteMemberOk", method=RequestMethod.POST)
	public String deleteMemberOk(@RequestParam String mb_id, HttpSession session) {
		memberService.updateLev(mb_id, -1);
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "admin/intercept")
	public String intercept(@RequestParam String mb_id) {
		memberService.updateLev(mb_id, -2);
		return "redirect:/admin/memberAll";
	}

	@RequestMapping(value = "findid")
	public String findid(Model model) {
		List<List<MenuVO>> mlist = menuService.listoflist();
 		model.addAttribute("mlist",mlist);
		return "index/member/findid";
	}

	@RequestMapping(value = "idin", method= {RequestMethod.POST,RequestMethod.GET})
	public String findidOk(@RequestParam String mb_name, @RequestParam String mb_email, Model model) {
		String mb_id = memberService.findid(mb_name, mb_email);
		if(mb_id != null) {
			int getlev = memberService.getLev(mb_id);
			model.addAttribute("mb_lev", getlev);
			model.addAttribute("mb_id", mb_id);
		}
		List<List<MenuVO>> mlist = menuService.listoflist();
 		model.addAttribute("mlist",mlist);
		model.addAttribute("mb_id", mb_id);
		return "index/member/idin";
	}
	
	@RequestMapping(value = "findpw")
	public String findpw(Model model) {
		List<List<MenuVO>> mlist = menuService.listoflist();
 		model.addAttribute("mlist",mlist);
		return "index/member/findpw";
	}

	@RequestMapping(value = "findpwOk", method= {RequestMethod.POST,RequestMethod.GET})
	public String findpwOk(@RequestParam final String mb_id, @RequestParam final String mb_email, Model model) {
		final String mb_password = memberService.findpw(mb_id, mb_email);
		if(mb_password != null) {
			int getlev = memberService.getLev(mb_id);
			final String getname = memberService.selectByName(mb_id);
			if(getlev>=0) {
				MimeMessagePreparator preparator = new MimeMessagePreparator() {
					
					@Override
					public void prepare(MimeMessage mimeMessage) throws Exception {
						mimeMessage.setFrom("dnjstjr0507@naver.com");
						mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(mb_email));
						mimeMessage.setSubject("비밀번호 재설정");
						String setkey = "";
						Random rnd =new Random();
						StringBuffer sb = new StringBuffer();
						for(int i=0;i<20;i++)
						    // rnd.nextBoolean() 는 랜덤으로 true, false 를 리턴. true일 시 랜덤 한 소문자를, false 일 시 랜덤 한 숫자를 StringBuffer 에 append 한다.
						    setkey += ((char)((int)(rnd.nextInt(26))+97));
						
						memberService.updatesetkey(mb_id, setkey);
						final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8"); // true (html태그 사용 가능하게)	// "UTF-8"(UTF-8로 인코딩)
						sb.append(getname + "님 집나간 비밀번호를 링크를 클릭하여 재설정 해주세요.<br>");
						helper.setText(
								sb.append("<a href='http://localhost:8080/travel/updatePW?mb_id=").append(mb_id)
									.append("&setkey=").append(setkey)
									.append("' target='_blank'>비밀번호 재설정</a><br>")
									.append("만약 비밀번호 재설정 요청을 하지 않으셨다면 고객센터에 문의 바랍니다. <br> 비밀번호를 변경하고 싶지 않다면 메일을 무시 하시면 됩니다.<br> ").toString(),
								true);
						
					}
				};
				mailSender.send(preparator);
				return "redirect:/";
			}else {
				// -1, -2 아이디
				return "redirect:/findpw"; 
			}
		}
		return "index/member/pwMessage";
	}
	
	@RequestMapping(value="updatePW")
	public String updatePW(@RequestParam String mb_id,@RequestParam String setkey ,Model model) {
		List<List<MenuVO>> mlist = menuService.listoflist();
 		model.addAttribute("mlist",mlist);
		model.addAttribute("mb_id", mb_id);
		model.addAttribute("setkey", setkey);
		return "index/member/updatePW";
	}
	
	@RequestMapping(value="updatePWOk")
	public String updatePWOk(@RequestParam String mb_id,@RequestParam String setkey ,@RequestParam String mb_password) {
		memberService.updatePW(mb_id,mb_password,setkey);
		memberService.updatesetkey(mb_id, "");
		
		return "redirect:/";
	}
	
	@RequestMapping(value="admin/memberAll")
	public String selectMemberAll(Model model) {
		List<MemberVO> membervo = memberService.selectMemberAll();
		model.addAttribute("membervo", membervo);
		return "admin/memberAll";
	}
	
	@RequestMapping(value="mypage")
	public String mypage(HttpSession session ,Model model, HttpServletRequest request) {
		MemberVO vo = (MemberVO) session.getAttribute("vo");
		List<List<MenuVO>> mlist = menuService.listoflist();
		model.addAttribute("result", request.getParameter("result"));
		model.addAttribute("mlist",mlist);
 		if(vo != null) {
			return "index/mypage/mypage";
		}else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="updatePassword")
	public String updatePassword(HttpSession session, Model model) {
		MemberVO vo = (MemberVO) session.getAttribute("vo");
		List<List<MenuVO>> mlist = menuService.listoflist();
		model.addAttribute("mlist",mlist);
		if(vo != null) {
			return "index/mypage/updatePassword";
		}else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="updatePasswordsuccess")
	public String updatePasswordsuccess(HttpSession session,@RequestParam String pwCk , @RequestParam String mb_password) {
		MemberVO vo = (MemberVO) session.getAttribute("vo");
		int result = memberService.ajax_passwordCK(vo.getMb_id(), pwCk);
		if(result == 1) {
			if(vo != null && mb_password != null) {
				memberService.updatePassword(vo.getMb_id(), mb_password);
				session.invalidate();
				return "redirect:/signin?resultMessage=" + result;
			}else {
				return "redirect:/";
			}
		}else {
			return "redirect:/mypage?result=" + result;
		}
	}
}
