package com.lsj.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lsj.domain.RasberryVO;
import com.lsj.domain.RasberryloginVO;
import com.lsj.service.RasberryService;
import com.lsj.service.RasberryloginService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	@Autowired
    private RasberryService rasberryService;
	
	@Autowired
	private RasberryloginService rasberryloginService;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login() {
		
		return "login";
	}
	
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(RasberryloginVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception{
		System.out.println("login--------------------");
		
		HttpSession session = req.getSession();
		System.out.println(rasberryloginService.login(vo));
		RasberryloginVO login = rasberryloginService.login(vo);
		
		if(login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			return "redirect:/";

		}else {
			session.setAttribute("member", login);
			return "redirect:/list";
		}
		
	}
	
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value = {"/list"}, method = RequestMethod.GET)
    public String listrasberry(HttpServletRequest req, Model model) throws Exception {
		HttpSession session = req.getSession();
		RasberryloginVO loginVO = (RasberryloginVO) session.getAttribute("member");
		
		if(loginVO == null) {
			 return "redirect:/";
		}
		else {
			List<RasberryVO> temp = rasberryService.readRasberryList();
	    	
	        JSONArray jsonArray = new JSONArray();
	        JSONObject jsonObject = new JSONObject();
	        
	        for (int i = 0; i < temp.size(); i++) {			
				jsonObject.put("temp", temp.get(i).getTemp());
				jsonObject.put("hud", temp.get(i).getHud());
				jsonObject.put("id", temp.get(i).getId());
				jsonObject.put("time", temp.get(i).getTime());
				jsonObject.put("isOn", temp.get(i).isOn());
				
				jsonArray.add(jsonObject);
			}
	        
	        model.addAttribute("jsonList", jsonArray);
	        model.addAttribute("temp", temp);
	        
	        return "rasberry/rasberry_list";
		}
    }
	
	@RequestMapping(value = {"/googleChart"}, method = RequestMethod.GET)
    public String googleChart(Model model) throws Exception {
        return "rasberry/googleChart";
    }
	
}
