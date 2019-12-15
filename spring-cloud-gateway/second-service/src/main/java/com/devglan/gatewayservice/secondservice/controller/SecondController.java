package com.devglan.gatewayservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SecondController {

    @GetMapping("/test")
    public String test(@RequestHeader("X-second-Header") String headerValue){
        return headerValue;
    }

}
