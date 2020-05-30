package com.lsj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping(value="/test")
public class TestController {

	@RequestMapping(value = {"/home"}, method = RequestMethod.GET)
    public String listrasberry(Model model) throws Exception {
		return "home";
    }
   
}