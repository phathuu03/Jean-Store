package com.example.demo.controller.online;

import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;


@Controller
@RequestMapping("/public/")
@CrossOrigin("*")
public class GiaoHangNhanhController {

    private final String TOKEN = "249120b4-fef2-11ef-91ea-021c91d80158";

    private static final String API_BASE_URL = "https://online-gateway.ghn.vn/shiip/public-api/master-data/";

    @GetMapping("/provinces")
    @ResponseBody
    public String getAllProvinces() {
        try {
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.set("token", TOKEN);
            headers.set("Content-Type", "application/json");
            HttpEntity<String> entity = new HttpEntity<>(headers);
            ResponseEntity<String> response = restTemplate.exchange(API_BASE_URL + "province", HttpMethod.GET, entity, String.class);

            if (response.getStatusCode().is2xxSuccessful()) {
                return response.getBody();
            } else {
                return null;
            }
        } catch (HttpClientErrorException e) {
            return "";
        }
    }

    @GetMapping("/districts")
    @ResponseBody
    public String getDistrictsByProvince(@RequestParam("province_id") Integer provinceId) {
        try {
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.set("token", TOKEN);
            headers.set("Content-Type", "application/json");
            HttpEntity<String> entity = new HttpEntity<>(headers);
            ResponseEntity<String> response = restTemplate.exchange(API_BASE_URL + "district?province_id=" + provinceId, HttpMethod.GET, entity, String.class);

            if (response.getStatusCode().is2xxSuccessful()) {
                return response.getBody();
            } else {
                return null;
            }
        } catch (HttpClientErrorException e) {
            return "";
        }
    }

    @GetMapping("/wards")
    @ResponseBody
    public String getWardsByDistrict(@RequestParam("district_id") Integer districtId) {
        try {
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.set("token", TOKEN);
            headers.set("Content-Type", "application/json");
            HttpEntity<String> entity = new HttpEntity<>(headers);
            ResponseEntity<String> response = restTemplate.exchange(API_BASE_URL + "ward?district_id=" + districtId, HttpMethod.GET, entity, String.class);

            if (response.getStatusCode().is2xxSuccessful()) {
                return response.getBody();
            } else {
                return null;
            }
        } catch (HttpClientErrorException e) {
            return "";
        }
    }

    @PostMapping("/transportationFee")
    @ResponseBody
    public ResponseEntity<String> getFee(
            @RequestParam("to_district_id") Integer to_district_id,
            @RequestParam("to_ward_code") String to_ward_code, // GHN yêu cầu kiểu String
            @RequestParam("quantity") Long quantity
    ) {
        try {
            RestTemplate restTemplate = new RestTemplate();

            // Tạo tiêu đề
            HttpHeaders headers = new HttpHeaders();
            headers.set("token", TOKEN);
            headers.set("Content-Type", "application/json");

            // Tạo đối tượng HttpEntity chứa tiêu đề
            HttpEntity<String> entity = new HttpEntity<>(headers);

            // Tạo URL API
            String url = "https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee" +
                    "?service_type_id=2" +
                    "&from_district_id=3440" +
                    "&to_district_id=" + to_district_id +
                    "&to_ward_code=" + to_ward_code +
                    "&height=1" +
                    "&length=40" +
                    "&weight=" + (500 * quantity) +
                    "&width=" + (20 * quantity);

            // Gửi request đến GHN
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

            return ResponseEntity.status(response.getStatusCode()).body(response.getBody());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Lỗi khi gọi API GHN: " + e.getMessage());
        }
    }

}
