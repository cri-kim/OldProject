package com.runtime6.web.example.controller;
 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


 
@Controller
public class PayController {
   @RequestMapping("/pay")
   public String list() {
      System.out.println("/pay controller진입1");
      return "pay";
      }
}