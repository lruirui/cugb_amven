package com.lsy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping
public class index {
    @RequestMapping("/index")
    public String index() {
        return "indexDB";
    }
    @RequestMapping("/admin/home")
    public String home() {
        return  "admin/home";
    }
}
