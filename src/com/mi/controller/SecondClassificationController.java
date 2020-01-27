package com.mi.controller;

import com.mi.model.bean.FirstClassification;
import com.mi.model.bean.SecondClassification;
import com.mi.model.service.SecondClassificationService;
import com.mi.model.tools.CusMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 上午11:06
 */
@Controller
public class SecondClassificationController {

    @Autowired
    private SecondClassificationService secondClassificationService;

    @RequestMapping("getAllScs")
    @ResponseBody
    public Map<String, Object> getAllFcs(String scName, String fcId, String page, String limit){
        System.out.println(scName + "---" + fcId + "---" + page + "---" + limit);
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", secondClassificationService.selectAllScsCount(scName, fcId));
        List<SecondClassification> scs = secondClassificationService.selectAllScs(scName, fcId, page, limit);
        result.put("data", scs);
        return result;
    }

    @RequestMapping("deleteSc")
    @ResponseBody
    public String deleteFc(String scId){
        secondClassificationService.deleteSc(Integer.parseInt(scId));
        return "success";
    }

    @RequestMapping("addSc")
    @ResponseBody
    public String addSc(SecondClassification sc){
        if (sc.getFcId() == 0){
            return "fc";
        }else if (sc.getScName() == null || sc.getScName().equals("")){
            return "name";
        }else if (sc.getScUrl() == null || sc.getScUrl().equals("")){
            return "url";
        }
        sc.setScId(CusMethod.randomId());
        secondClassificationService.addSc(sc);
        return "success";
    }

    @RequestMapping("updateSc")
    @ResponseBody
    public String updateSc(SecondClassification sc){
        if (sc.getFcId() == 0){
            return "fc";
        }else if (sc.getScName() == null || sc.getScName().equals("")){
            return "name";
        }else if (sc.getScUrl() == null || sc.getScUrl().equals("")){
            return "url";
        }
        secondClassificationService.updateSc(sc);
        return "success";
    }

    @RequestMapping("getScById")
    public String getScById(int scId, Model model){
        SecondClassification sc = secondClassificationService.selectScById(scId);
        model.addAttribute("sc", sc);
        return "scEdit";
    }

    /*根据一级分类返回全部二级分类*/
    @RequestMapping("selectScByFc")
    public @ResponseBody List<SecondClassification> selectScByFc(String fcId){
        List<SecondClassification> scList = secondClassificationService.selectScByFc(fcId);
        return scList;
    }
    /*根据一级分类返回全部二级分类跳转回去*/
    @RequestMapping("selectScByFcRedirect")
    public String selectScByFcRedirect(HttpSession session, String fcId, String scId,
                                       String fcName){
        List<SecondClassification> scList = secondClassificationService.selectScByFc(fcId);
        session.setAttribute("scList",scList);
        session.setAttribute("fcName",fcName);
        session.setAttribute("scId",scId);
        session.setAttribute("fcId",fcId);
        return "redirect:productList.jsp";
    }

    /**
     * get portion second classifications which contain the latest new products by id of first classification
     * @param fcId id of first classification
     * @param amount amount of products
     * @return list of second classifications which contain the latest new products
     * @author huang jiarui
     * @version 1.1
     */
    @RequestMapping("/secondClassificationController/getLatestPortionSecondClassificationByFcId.action")
    @ResponseBody
    public List<SecondClassification> getLatestPortionSecondClassificationByFcId(Integer fcId, Integer amount){
        System.out.println(fcId + " " + amount);
        return secondClassificationService.getLatestPortionSecondClassificationByFcId(fcId,amount);
    }
}
