package com.lsj.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@RequestMapping(value = {"/register"}, method = RequestMethod.GET)
    public String register(Model model) throws Exception {
        return "rasberry/register";
    }
	
	@RequestMapping(value = {"/registering"}, method = RequestMethod.POST)
    public String registering(@RequestParam("passwd")String passwd, @RequestParam("serialnumber")String serialnumber, Model model) throws Exception {
		RasberryVO vo = new RasberryVO();
		RasberryloginVO loginVO = new RasberryloginVO();
		
		loginVO.setPasswd(passwd);
		loginVO.setSerialnumber(serialnumber);
		vo.setSerialnumber(serialnumber);

		if(rasberryService.selectOnoff(vo) == null) {
			RasberryloginVO login = rasberryloginService.login(loginVO);
			
			if(login == null) {
				model.addAttribute("msg", "등록 실패하였습니다");
				return "rasberry/register";
			}
			else {
				rasberryService.insertOnoff(serialnumber);
				return "rasberry/login";
			}
		}
		else {
			model.addAttribute("msg", "이미 등록되었습니다");
			return "rasberry/register";
		}
    }
	
	@RequestMapping(value = {"/login"}, method = RequestMethod.GET)
    public String login2(Model model) throws Exception {
        return "rasberry/login";
    }
	
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "infoSet", method = RequestMethod.POST)
	@ResponseBody
	public String crawlingSet(HttpServletRequest request, RasberryVO vo) throws Exception{
		HttpSession session = request.getSession();
		RasberryloginVO loginVO = (RasberryloginVO) session.getAttribute("member");
		
		int autoOnoff = Integer.parseInt(request.getParameter("autoOnoff"));
		int manualOnoff = Integer.parseInt(request.getParameter("manualOnoff"));
		
		long startTime = System.currentTimeMillis();    
		Timestamp time = new Timestamp(startTime);
		vo.setTime(time);
		vo.setSerialnumber(loginVO.getSerialnumber());
		rasberryService.updateOnoff(vo);
		
		return "rasberry/auto:"+autoOnoff+"/manual:"+manualOnoff;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login() {
		return "rasberry/login";
	}
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(RasberryloginVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception{
		HttpSession session = req.getSession();
		RasberryloginVO login = rasberryloginService.login(vo);
		
		if(login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			return "redirect:/";

		}else {
			session.setAttribute("member", login);
			return "redirect:/main";
		}
	}
	
	@RequestMapping(value = {"/main"}, method = RequestMethod.GET)
    public String main(HttpServletRequest req, RasberryVO vo, Model model) throws Exception {
		HttpSession session = req.getSession();
		RasberryloginVO loginVO = (RasberryloginVO) session.getAttribute("member");
		
		if(loginVO == null) {
			 return "redirect:/";
		}
		else {
			SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
			Date time = new Date();
			String timeNow = format.format(time);
			
			vo.setDatePicker(timeNow);
			vo.setSerialnumber(loginVO.getSerialnumber());
			
			List<RasberryVO> temp = rasberryService.readRasberryList(vo);
	    	
	        JSONArray jsonArray = new JSONArray();
	        JSONObject jsonObject = new JSONObject();
	        
	        for (int i = 0; i < temp.size(); i++) {			
	        	jsonObject.put("temp_in", temp.get(i).getTemp_in());
				jsonObject.put("hud_in", temp.get(i).getHud_in());
				jsonObject.put("temp_out", temp.get(i).getTemp_out());
				jsonObject.put("hud_out", temp.get(i).getHud_out());
				jsonObject.put("id", temp.get(i).getSerialnumber());
				jsonObject.put("time", temp.get(i).getTime());
				jsonObject.put("isOn", temp.get(i).getIsOn());
				
				jsonArray.add(jsonObject);
			}
	        
	        float discomfortRate = 0;
	        
	        if(temp.size() > 0) {
	        	float a,b,c,d = 0;
	        	float t = temp.get(0).getTemp_in();
	        	float h = temp.get(0).getHud_in();
	        	
	        	a = (float) ((1.8)*t);
		        b = (float) ((0.55)*(1 - (h*(0.01))));
		        c = (float) (a - 26.0);
		        d = (float) (a - (b*c) + 32.0);
		        
	        	discomfortRate = d;
	        }
	        
        	vo.setSerialnumber(loginVO.getSerialnumber());
	        RasberryVO onOffVO = rasberryService.selectOnoff(vo);
	        
	        model.addAttribute("loginVO", loginVO);
	        model.addAttribute("onOffVO", onOffVO);
	        model.addAttribute("discomfortRate", discomfortRate);
	        model.addAttribute("jsonList", jsonArray);
	        model.addAttribute("datePicker", vo.getDatePicker());
	        
	        return "rasberry/main";
		}
    }
	
	@RequestMapping(value = {"/mainDatePicker"}, method = RequestMethod.POST)
    public String mainDatePicker(HttpServletRequest req, RasberryVO vo, Model model) throws Exception {
		HttpSession session = req.getSession();
		RasberryloginVO loginVO = (RasberryloginVO) session.getAttribute("member");
		
		if(loginVO == null) {
			 return "redirect:/";
		}
		else {
			vo.setSerialnumber(loginVO.getSerialnumber());
			List<RasberryVO> temp = rasberryService.readRasberryList(vo);
	    	
	        JSONArray jsonArray = new JSONArray();
	        JSONObject jsonObject = new JSONObject();
	        
	        for (int i = 0; i < temp.size(); i++) {			
	        	jsonObject.put("temp_in", temp.get(i).getTemp_in());
				jsonObject.put("hud_in", temp.get(i).getHud_in());
				jsonObject.put("temp_out", temp.get(i).getTemp_out());
				jsonObject.put("hud_out", temp.get(i).getHud_out());
				jsonObject.put("id", temp.get(i).getSerialnumber());
				jsonObject.put("time", temp.get(i).getTime());
				jsonObject.put("isOn", temp.get(i).getIsOn());
				
				jsonArray.add(jsonObject);
			}
	        
	        float discomfortRate = 0;
	        
	        if(temp.size() > 0) {
	        	float a,b,c,d = 0;
	        	float t = temp.get(0).getTemp_in();
	        	float h = temp.get(0).getHud_in();
	        	
	        	a = (float) ((1.8)*t);
		        b = (float) ((0.55)*(1 - (h*(0.01))));
		        c = (float) (a - 26.0);
		        d = (float) (a - (b*c) + 32.0);
		        
	        	discomfortRate = d;
	        }

	        vo.setSerialnumber(loginVO.getSerialnumber());
	        RasberryVO onOffVO = rasberryService.selectOnoff(vo);

	        model.addAttribute("loginVO", loginVO);
	        model.addAttribute("onOffVO", onOffVO);
	        model.addAttribute("discomfortRate", discomfortRate);
	        model.addAttribute("jsonList", jsonArray);
	        model.addAttribute("datePicker", vo.getDatePicker());
	        
	        return "rasberry/main";
		}
    }
	
}