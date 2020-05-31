package com.lsj.controller;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lsj.domain.RasberryVO;
import com.lsj.service.RasberryService;
import com.mysql.cj.xdevapi.JsonArray;
import com.mysql.cj.xdevapi.JsonValue;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.groovy.GJson;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	@Autowired
    private RasberryService rasberryService;
	
	@RequestMapping(value = {"/"}, method = RequestMethod.GET)
    public String listrasberry(Model model) throws Exception {
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
	
	@RequestMapping(value = {"/googleChart"}, method = RequestMethod.GET)
    public String googleChart(Model model) throws Exception {
        return "rasberry/googleChart";
    }
	
}
