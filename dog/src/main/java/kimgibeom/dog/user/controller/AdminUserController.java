package kimgibeom.dog.user.controller;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kimgibeom.dog.user.domain.User;
import kimgibeom.dog.user.domain.UserPagination;
import kimgibeom.dog.user.domain.UserSearch;
import kimgibeom.dog.user.service.UserService;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {
	@Autowired private UserService userService;
	
	@RequestMapping("/userListView")
	public String moveUserListView(Model model, @RequestParam(required=false, defaultValue="1") int page,
								   @RequestParam(required=false, defaultValue="1") int range,
								   @RequestParam(required=false) String keyword,
								   @RequestParam(required=false, defaultValue="userId") String searchType){
		UserSearch userSearch = new UserSearch();
		
		if(keyword == null) keyword = "";
		userSearch.setSearchType(searchType);
		userSearch.setKeyword(keyword);
		
		System.out.println(page);
		System.out.println(range);
		System.out.println(keyword);
		System.out.println(searchType);
				
		int listCnt = userService.readUserListCnt(userSearch);
		userSearch.pageInfo(page, range, listCnt);

		model.addAttribute("pagination", userSearch);
		model.addAttribute("userList", userService.readUserList(userSearch));
		
		return "admin/user/userListView";
	}
	
	@ResponseBody
	@RequestMapping("/userDel")
	public void userDel(@RequestParam(value="userIds[]") List<String> userIds) {
		for (String userId: userIds) {
			userService.withdrawUser(userId);
		}
	}
	
	@RequestMapping("/userRegist")
	public void userRegist() {
	}
	
	// 관리자 회원 등록
	@RequestMapping(value = "/userRegistProc", method = RequestMethod.POST)
	public void userRegistProc(String userId, String userPw, String userName, String userPhone, String userEmail) {
		Date data = new Date(1111, 11, 11);
		User user = new User(userId, userPw, userName, userPhone, userEmail, data);
		userService.writeUser(user);
	}
	
	// 관리자 회원 등록 시 id중복 체크
	@RequestMapping("/idCheck")
	@ResponseBody
	public boolean idCheck(String userId) {
		if (userService.idCheck(userId)) { // 중복이 아니면 true로 출력
			return true;
		} else { // 이미 사용중인 ID인 경우 false 값 return
			return false;
		}
	}
}
