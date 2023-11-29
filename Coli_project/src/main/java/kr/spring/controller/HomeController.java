package kr.spring.controller;

import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.entity.Article;
import kr.spring.service.ArticleFileService;
import kr.spring.service.ArticleService;

@Controller
public class HomeController {
   
   @Autowired
    private ArticleService articleService;
   
    @Autowired
    private ArticleFileService articleFileService;
    
   @RequestMapping("/")
   public String index(Model model) {
      // 게시글 목록을 서비스를 통해 가져오기
        List<Article> articles = articleService.getList();        
        // 모델에 게시글 목록 추가
        articles.sort(Comparator.comparingLong(Article::getAtc_id).reversed());
        model.addAttribute("articles", articles);
      return "index";
   }
   
   @RequestMapping("plan")
   public String plan() {
      return "plan";
   }
   
   @RequestMapping("draw")
   public String draw() {
      return "draw";
   }
   
   @RequestMapping("price")
   public String price() {
      return "price";
   }
   
   @RequestMapping("draw2")
   public String draw2() {
      return "draw2";
   }
   
   @RequestMapping("draw3")
   public String draw3() {
      return "draw3";
   }
   
   @RequestMapping("draw4")
   public String draw4() {
      return "draw4";
   }
}