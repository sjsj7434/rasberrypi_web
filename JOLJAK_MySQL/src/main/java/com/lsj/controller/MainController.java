package com.lsj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lsj.domain.RasberryVO;
import com.lsj.service.RasberryService;

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
        model.addAttribute("temp", temp);
        
        return "rasberry/rasberry_list";
    }
	
	@RequestMapping(value = {"/googleChart"}, method = RequestMethod.GET)
    public String googleChart(Model model) throws Exception {
        return "rasberry/googleChart";
    }
	
}
