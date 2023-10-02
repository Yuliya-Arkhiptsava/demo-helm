package org.demo.helm.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PingController {

  private static final String PONG = "pong";

  @RequestMapping("/ping")
  public String ping() {
    return PONG;
  }
}
